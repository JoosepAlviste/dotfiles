from collections import namedtuple
from functools import total_ordering
import os.path
import re
import sys

from kitty.cli import parse_args
from kitty.conf.definition import config_lines, option_func
from kitty.conf.utils import (
    init_config, key_func, load_config, merge_dicts, parse_config_base,
    parse_kittens_key, resolve_config, to_color)
from kitty.constants import config_dir
from kitty.fast_data_types import (
    set_clipboard_string, truncate_point_for_length, wcswidth)
import kitty.key_encoding as kk
from kitty.rgb import color_as_sgr
from kittens.tui.handler import Handler
from kittens.tui.loop import Loop


PositionBase = namedtuple('Position', ['x', 'y', 'top_line'])
@total_ordering
class Position(PositionBase):
    @property
    def line(self):
        return self.y + self.top_line

    def moved(self, dx=0, dy=0, dtop=0):
        return self._replace(x=self.x + dx, y=self.y + dy,
                             top_line=self.top_line + dtop)

    def __lt__(self, other):
        return (self.line, self.x) < (other.line, other.x)


class Region:
    @staticmethod
    def line_inside_region(current_line, start, end):
        return False

    @staticmethod
    def line_outside_region(current_line, start, end):
        return current_line < start.line or end.line < current_line

    @staticmethod
    def adjust(start, end):
        return start, end

    @staticmethod
    def selection_in_line(current_line, start, end, maxx):
        return None, None

    @staticmethod
    def lines_affected(start, end, line, dx, dy):
        return {}


class NoRegion(Region):
    name = 'unselected'
    uses_mark = False

    @staticmethod
    def line_outside_region(current_line, start, end):
        return False


class StreamRegion(Region):
    name = 'stream'
    uses_mark = True

    @staticmethod
    def line_inside_region(current_line, start, end):
        return start.line < current_line < end.line

    @staticmethod
    def selection_in_line(current_line, start, end, maxx):
        if StreamRegion.line_outside_region(current_line, start, end):
            return None, None
        return (start.x if current_line == start.line else 0,
                end.x if current_line == end.line else maxx)

    @staticmethod
    def lines_affected(start, end, line, dx, dy):
        return {line, line - dy}


class ColumnarRegion(Region):
    name = 'columnar'
    uses_mark = True

    @staticmethod
    def adjust(start, end):
        return (start._replace(x=min(start.x, end.x)),
                end._replace(x=max(start.x, end.x)))

    @staticmethod
    def selection_in_line(current_line, start, end, maxx):
        if ColumnarRegion.line_outside_region(current_line, start, end):
            return None, None
        return start.x, end.x

    @staticmethod
    def lines_affected(start, end, line, dx, dy):
        return range(start.line, end.line + 1) if dx else {line, line - dy}


def parse_opts():
    all_options = {}
    o, k, g, all_groups = option_func(all_options, {
        'shortcuts': ['Keyboard shortcuts'],
        'colors': ['Colors']
    })

    g('shortcuts')
    k('quit', 'q', 'quit')
    k('quit', 'esc', 'quit')
    k('confirm', 'enter', 'confirm')
    k('left', 'left', 'move left')
    k('right', 'right', 'move right')
    k('up', 'up', 'move up')
    k('down', 'down', 'move down')
    k('scroll up', 'ctrl+up', 'scroll up')
    k('scroll down', 'ctrl+down', 'scroll down')
    k('select left', 'shift+left', 'select stream left')
    k('select right', 'shift+right', 'select stream right')
    k('select up', 'shift+up', 'select stream up')
    k('select down', 'shift+down', 'select stream down')
    k('column select left', 'alt+left', 'select columnar left')
    k('column select right', 'alt+right', 'select columnar right')
    k('column select up', 'alt+up', 'select columnar up')
    k('column select down', 'alt+down', 'select columnar down')

    g('colors')
    o('selection_foreground', '#FFFFFF', option_type=to_color)
    o('selection_background', '#5294E2', option_type=to_color)

    type_map = {o.name: o.option_type
                for o in all_options.values()
                if hasattr(o, 'option_type')}

    defaults = None

    func_with_args, args_funcs = key_func()
    def special_handling(key, val, result):
        if key == 'map':
            action, *key_def = parse_kittens_key(val, args_funcs)
            result['key_definitions'][tuple(key_def)] = action
            return True
        return False

    def parse_config(lines, check_keys=True):
        result = {'key_definitions': {}}
        parse_config_base(lines, defaults, type_map, special_handling,
                          result, check_keys=check_keys)
        return result

    def merge_configs(defaults, vals):
        return {k: (merge_dicts(v, vals.get(k, {}))
                    if isinstance(v, dict)
                    else vals.get(k, v))
                for k, v in defaults.items()}

    @func_with_args('move')
    def move(func, direction):
        assert direction.lower() in ['left', 'right', 'up', 'down']
        return func, direction.lower()

    @func_with_args('scroll')
    def scroll(func, direction):
        assert direction.lower() in ['up', 'down']
        return func, direction.lower()

    @func_with_args('select')
    def select(func, args):
        region_type, direction = args.split(' ', 1)
        assert region_type.lower() in ['stream', 'columnar']
        assert direction.lower() in ['left', 'right', 'up', 'down']
        return func, (region_type.lower(), direction.lower())

    Options, defaults = init_config(config_lines(all_options), parse_config)
    configs = list(resolve_config('/etc/xdg/kitty/grab.conf',
                                  os.path.join(config_dir, 'grab.conf'),
                                  config_files_on_cmd_line=None))
    return load_config(Options, defaults, parse_config, merge_configs, *configs)


def unstyled(s):
    return re.sub(r'\x1b\[[0-9;:]*m', '', s)


def string_slice(s, start_x, end_x):
    prev_pos = truncate_point_for_length(s, start_x - 1) if start_x > 0 else None
    start_pos = truncate_point_for_length(s, start_x)
    end_pos = truncate_point_for_length(s, end_x - 1) + 1
    return s[start_pos:end_pos], prev_pos == start_pos


class GrabHandler(Handler):
    def __init__(self, args, opts, lines):
        super().__init__()
        self.args = args
        self.opts = opts
        self.lines = lines
        self.point = Position(args.x, args.y, args.top_line)
        self.mark = None
        self.mark_type = NoRegion
        self.result = None
        for key_def, action in self.opts.key_definitions.items():
            self.add_shortcut(action, *key_def)

    def _start_end(self):
        start, end = sorted([self.point, self.mark or self.point])
        return self.mark_type.adjust(start, end)

    def _draw_line(self, current_line):
        y = current_line - self.point.top_line
        line = self.lines[current_line - 1]
        clear_eol = '\x1b[m\x1b[K'
        sgr0 = '\x1b[m'

        plain = unstyled(line)
        selection_sgr = '\x1b[38{};48{}m'.format(
            color_as_sgr(self.opts.selection_foreground),
            color_as_sgr(self.opts.selection_background))
        start, end = self._start_end()

        # anti-flicker optimization
        if self.mark_type.line_inside_region(current_line, start, end):
            self.cmd.set_cursor_position(0, y)
            self.print('{}{}'.format(selection_sgr, plain),
                       end=clear_eol)
            return

        self.cmd.set_cursor_position(0, y)
        self.print('{}{}'.format(sgr0, line), end=clear_eol)

        if self.mark_type.line_outside_region(current_line, start, end):
            return

        start_x, end_x = self.mark_type.selection_in_line(
            current_line, start, end, wcswidth(plain))
        if start_x is None and end_x is None:
            return

        line_slice, half = string_slice(plain, start_x, end_x)
        self.cmd.set_cursor_position(start_x - (1 if half else 0), y)
        self.print('{}{}'.format(selection_sgr, line_slice), end='')

    def _update(self):
        self.cmd.set_window_title('Grab – {} {} {},{}+{} to {},{}+{}'.format(
            self.args.title,
            self.mark_type.name,
            getattr(self.mark, 'x', None), getattr(self.mark, 'y', None),
            getattr(self.mark, 'top_line', None),
            self.point.x, self.point.y, self.point.top_line))
        self.cmd.set_cursor_position(self.point.x, self.point.y)

    def _redraw_lines(self, lines):
        for line in lines:
            self._draw_line(line)
        self._update()

    def _redraw(self):
        self._redraw_lines(range(
            self.point.top_line,
            self.point.top_line + self.screen_size.rows))

    def initialize(self):
        self.cmd.set_window_title('Grab – {}'.format(self.args.title))
        self._redraw()

    def on_text(self, text, in_bracketed_paste=False):
        action = self.shortcut_action(text)
        if action is None:
            return
        self.perform_action(action)

    def on_key(self, key_event):
        action = self.shortcut_action(key_event)
        if (key_event.type not in [kk.PRESS, kk.REPEAT]
                or action is None):
            return
        self.perform_action(action)

    def perform_action(self, action):
        func, args = action
        getattr(self, func)(*args)

    def quit(self, *args):
        self.quit_loop(1)

    directions = {'left': (-1, 0),
                  'right': (1, 0),
                  'up': (0, -1),
                  'down': (0, 1)}
    region_types = {'stream': StreamRegion,
                    'columnar': ColumnarRegion}

    def _ensure_mark(self, mark_type=StreamRegion):
        need_redraw = mark_type is not self.mark_type
        self.mark_type = mark_type
        self.mark = (self.mark or self.point) if mark_type.uses_mark else None
        if need_redraw:
            self._redraw()

    def _scroll(self, dtop):
        if not (0 < self.point.top_line + dtop
                <= 1 + len(self.lines) - self.screen_size.rows):
            return
        self.point = self.point.moved(dtop=dtop)
        self._redraw()

    def scroll(self, direction):
        self._scroll(dtop=self.directions[direction][1])

    def _select(self, dx, dy, mark_type):
        self._ensure_mark(mark_type)
        if not 0 <= self.point.x + dx < self.screen_size.cols:
            return
        if not 0 <= self.point.y + dy < self.screen_size.rows:
            self._scroll(dtop=dy)
        else:
            self.point = self.point.moved(dx, dy)
        self._redraw_lines(self.mark_type.lines_affected(
            *self._start_end(), self.point.line, dx, dy))

    def move(self, direction):
        self._select(*self.directions[direction], NoRegion)

    def select(self, region_type, direction):
        self._select(*self.directions[direction],
                     self.region_types[region_type])

    def confirm(self, *args):
        start, end = self._start_end()
        self.result = {'copy': '\n'.join(
            line_slice
            for line in range(start.line, end.line + 1)
            for plain in [unstyled(self.lines[line - 1])]
            for start_x, end_x in [self.mark_type.selection_in_line(
                line, start, end, len(plain))]
            if start_x is not None and end_x is not None
            for line_slice, _half in [string_slice(plain, start_x, end_x)])}
        self.quit_loop(0)


def main(args):
    def ospec():
        return '''
--cursor-x
dest=x
type=int
(Internal) Starting cursor column, 0-based.


--cursor-y
dest=y
type=int
(Internal) Starting cursor line, 0-based.


--top-line
dest=top_line
type=int
(Internal) Window scroll offset, 1-based.


--title
(Internal)'''

    args, _rest = parse_args(args[1:], ospec)
    tty = open(os.ctermid())
    lines = (sys.stdin.buffer.read().decode('utf-8')
             .split('\n')[:-1])  # last line ends with \n, too
    sys.stdin = tty
    opts = parse_opts()
    handler = GrabHandler(args, opts, lines)
    loop = Loop()
    loop.loop(handler)
    return handler.result


def handle_result(args, result, target_window_id, boss):
    if 'copy' in result:
        set_clipboard_string(result['copy'])
