" vim:foldmethod=marker
" Vim Color File

" Color Reference {{{

" Taken from VSCode and Hyper Night Owl themes

" +-----------------------------------------------+
" |  Color Name    |         RGB        |   Hex   |
" |----------------+--------------------+---------|
" | Black          | rgb(40, 44, 52)    | #011627 |
" |----------------+--------------------+---------|
" | White          | rgb(171, 178, 191) | #ffffff |
" |----------------+--------------------+---------|
" | Dark White     | rgb(171, 178, 191) | #b2ccd6 |
" |----------------+--------------------+---------|
" | Light Red      | rgb(224, 108, 117) | #ff5874 |
" |----------------+--------------------+---------|
" | Dark Red       | rgb(190, 80, 70)   | #ef5350 |
" |----------------+--------------------+---------|
" | Green          | rgb(152, 195, 121) | #22da6e |
" |----------------+--------------------+---------|
" | Light Yellow   | rgb(229, 192, 123) | #ffeb95 |
" |----------------+--------------------+---------|
" | Dark Yellow    | rgb(209, 154, 102) | #addb67 |
" |----------------+--------------------+---------|
" | Light Blue     | rgb(97, 175, 239)  | #78ccf0 |
" |----------------+--------------------+---------|
" | Blue           | rgb(97, 175, 239)  | #82aaff |
" |----------------+--------------------+---------|
" | Magenta        | rgb(198, 120, 221) | #c792ea |
" |----------------+--------------------+---------|
" | Dark magenta   | rgb(198, 120, 221) | #da70d6 |
" |----------------+--------------------+---------|
" | Cyan           | rgb(86, 182, 194)  | #7fdbca |
" |----------------+--------------------+---------|
" | Dark Cyan      | rgb(86, 182, 194)  | #21c7a8 |
" |----------------+--------------------+---------|
" | Gutter Grey    | rgb(76, 82, 99)    | #4b6479 |
" |----------------+--------------------+---------|
" | Comment Grey   | rgb(92, 99, 112)   | #637777 |
" |----------------+--------------------+---------|
" | EXTRA          |                    |         |
" |----------------+--------------------+---------|
" | Orange         | rgb(92, 99, 112)   | #ecc48d |
" |----------------+--------------------+---------|
" | Dark orange    | rgb(92, 99, 112)   | #f78c6c |
" |----------------+--------------------+---------|
" | Active line nr | rgb(92, 99, 112)   | #c5e4fd |
" |----------------+--------------------+---------|
" | Search result  | rgb(92, 99, 112)   | #2e3c68 |
" |----------------+--------------------+---------|
" | Paren yellow   | rgb(92, 99, 112)   | #fdd700 |
" |----------------+--------------------+---------|
" | Diff add       | rgb(92, 99, 112)   | #264B33 |
" |----------------+--------------------+---------|
" | Diff delete    | rgb(92, 99, 112)   | #4B1515 |
" |----------------+--------------------+---------|
" | Diff changed   | rgb(92, 99, 112)   | #12404B |
" |----------------+--------------------+---------|
" | Diff changed hl| rgb(92, 99, 112)   | #43698D |
" +-----------------------------------------------+

" }}}

" Initialization {{{

highlight clear

if exists("syntax_on")
    syntax reset
endif

set t_Co=256

let g:colors_name="nightowl"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
if !exists("g:nightowl_termcolors")
  let g:nightowl_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:nightowl_terminal_italics")
  let g:nightowl_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `nightowl_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from nightowl#extend_highlight
    let a:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(a:highlight, style_type) ? a:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let a:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let a:highlight.gui = a:style.gui
    endif
  else
    let a:highlight = a:style
    let s:group_colors[a:group] = a:highlight " Cache default highlight group settings
  endif

  if g:nightowl_terminal_italics == 0
    if has_key(a:highlight, "cterm") && a:highlight["cterm"] == "italic"
      unlet a:highlight.cterm
    endif
    if has_key(a:highlight, "gui") && a:highlight["gui"] == "italic"
      unlet a:highlight.gui
    endif
  endif

  if g:nightowl_termcolors == 16
    let l:ctermfg = (has_key(a:highlight, "fg") ? a:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:highlight, "bg") ? a:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:highlight, "fg") ? a:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:highlight, "bg") ? a:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(a:highlight, "fg")    ? a:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:highlight, "bg")    ? a:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:highlight, "sp")    ? a:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(a:highlight, "gui")   ? a:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:highlight, "cterm") ? a:highlight.cterm    : "NONE")
endfunction

let s:overrides = get(g:, "nightowl_color_overrides", {})
let s:colors = {
      \ "red": get(s:overrides, "red", { "gui": "#ff5874", "cterm": "204", "cterm16": "1" }),
      \ "dark_red": get(s:overrides, "dark_red", { "gui": "#ef5350", "cterm": "196", "cterm16": "9" }),
      \ "green": get(s:overrides, "green", { "gui": "#22da6e", "cterm": "114", "cterm16": "2" }),
      \ "yellow": get(s:overrides, "yellow", { "gui": "#ffeb95", "cterm": "180", "cterm16": "3" }),
      \ "dark_yellow": get(s:overrides, "dark_yellow", { "gui": "#addb67", "cterm": "173", "cterm16": "11" }),
      \ "blue": get(s:overrides, "blue", { "gui": "#82aaff", "cterm": "39", "cterm16": "4" }),
      \ "light_blue": get(s:overrides, "light_blue", { "gui": "#78ccf0", "cterm": "39", "cterm16": "4" }),
      \ "purple": get(s:overrides, "purple", { "gui": "#c792ea", "cterm": "170", "cterm16": "5" }),
      \ "dark_purple": get(s:overrides, "dark_purple", { "gui": "#da70d6", "cterm": "170", "cterm16": "5" }),
      \ "cyan": get(s:overrides, "cyan", { "gui": "#7fdbca", "cterm": "38", "cterm16": "6" }),
      \ "dark_cyan": get(s:overrides, "dark_cyan", { "gui": "#21c7a8", "cterm": "38", "cterm16": "6" }),
      \ "white": get(s:overrides, "white", { "gui": "#ffffff", "cterm": "145", "cterm16": "7" }),
      \ "dark_white": get(s:overrides, "dark_white", { "gui": "#b2ccd6", "cterm": "145", "cterm16": "7" }),
      \ "black": get(s:overrides, "black", { "gui": "#011627", "cterm": "235", "cterm16": "0" }),
      \ "visual_black": get(s:overrides, "visual_black", { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }),
      \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#637777", "cterm": "59", "cterm16": "15" }),
      \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4b6479", "cterm": "238", "cterm16": "15" }),
      \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#01121f", "cterm": "236", "cterm16": "8" }),
      \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#1d3b53", "cterm": "237", "cterm16": "15" }),
      \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#2c3043", "cterm": "237", "cterm16": "8" }),
      \ "special_grey": get(s:overrides, "special_grey", { "gui": "#4b6479", "cterm": "238", "cterm16": "15" }),
      \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#1f385d", "cterm": "59", "cterm16": "15" }),
      \ "orange": get(s:overrides, "orange", { "gui": "#ecc48d", "cterm": "173", "cterm16": "11" }),
      \ "dark_orange": get(s:overrides, "dark_orange", { "gui": "#f78c6c", "cterm": "114", "cterm16": "2" }),
      \ "active_line_nr": get(s:overrides, "active_line_nr", { "gui": "#c5e4fd", "cterm": "114", "cterm16": "2" }),
      \ "search_result": get(s:overrides, "search_result", { "gui": "#2e3c68", "cterm": "114", "cterm16": "2" }),
      \ "paren_yellow": get(s:overrides, "paren_yellow", { "gui": "#fdd700", "cterm": "114", "cterm16": "2" }),
      \ "diff_add": get(s:overrides, "diff_add", { "gui": "#264b33", "cterm": "114", "cterm16": "2" }),
      \ "diff_delete": get(s:overrides, "diff_delete", { "gui": "#4B1515", "cterm": "114", "cterm16": "2" }),
      \ "diff_changed": get(s:overrides, "diff_changed", { "gui": "#12404B", "cterm": "114", "cterm16": "2" }),
      \ "diff_changed_highlight": get(s:overrides, "diff_changed_highlight", { "gui": "#43698D", "cterm": "114", "cterm16": "2" }),
      \}

let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:light_blue = s:colors.light_blue
let s:purple = s:colors.purple
let s:dark_purple = s:colors.dark_purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:dark_white = s:colors.dark_white
let s:black = s:colors.black
let s:visual_black = s:colors.visual_black " Black out selected text in 16-color visual mode
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit
let s:orange = s:colors.orange
let s:dark_orange = s:colors.dark_orange
let s:active_line_nr = s:colors.active_line_nr
let s:search_result = s:colors.search_result
let s:paren_yellow = s:colors.paren_yellow
let s:diff_add = s:colors.diff_add
let s:diff_delete = s:colors.diff_delete
let s:diff_changed = s:colors.diff_changed
let s:diff_changed_highlight = s:colors.diff_changed_highlight

" }}}

" Terminal Colors {{{

let g:terminal_ansi_colors = [
  \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:purple.gui, s:cyan.gui, s:white.gui,
  \ s:visual_grey.gui, s:dark_red.gui, s:green.gui, s:dark_yellow.gui,
  \ s:blue.gui, s:purple.gui, s:cyan.gui, s:comment_grey.gui
\]

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic" }) " any comment
call s:h("Constant", { "fg": s:blue }) " any constant
call s:h("String", { "fg": s:orange }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:dark_orange }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_orange }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:red }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_orange }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:white }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red }) " any other keyword
call s:h("Exception", { "fg": s:cyan }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:green }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:blue }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:orange }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:orange }) " A typedef
call s:h("Special", { "fg": s:dark_orange }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:dark_red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{

call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", {}) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:diff_add }) " diff mode: Added line
call s:h("DiffChange", { "bg": s:diff_changed }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:diff_delete }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:diff_changed_highlight }) " diff mode: Changed text within a changed line
call s:h("ErrorMsg", { "fg": s:dark_red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "bg": s:search_result }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", { "fg": s:active_line_nr }) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "bg": s:visual_grey }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:white }) " normal text
call s:h("Pmenu", { "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:black, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "bg": s:search_result }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green, "gui": "bold" }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:visual_black, "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Language-Specific Highlighting {{{

" JavaScript
call s:h("javaScriptFunction", { "fg": s:purple })
call s:h("javaScriptIdentifier", { "fg": s:purple })
call s:h("javaScriptNull", { "fg": s:red })
call s:h("javaScriptNumber", { "fg": s:dark_orange })
call s:h("javaScriptRequire", { "fg": s:cyan })
call s:h("javaScriptReserved", { "fg": s:purple })
" https://github.com/pangloss/vim-javascript
call s:h("jsComment", { "fg": s:comment_grey, "gui": "italic" })
call s:h("jsArrowFunction", { "fg": s:dark_purple })
call s:h("jsClassKeyword", { "fg": s:purple, "gui": "italic" })
call s:h("jsClassMethodType", { "fg": s:purple })
call s:h("jsClassDefinition", { "fg": s:orange })
call s:h("jsClassProperty", { "fg": s:white })
call s:h("jsObjectProp", { "fg": s:white })
call s:h("jsObjectKey", { "fg": s:white })
call s:h("jsDocParam", { "fg": s:comment_grey, "gui": "italic" })
call s:h("jsDocTags", { "fg": s:cyan, "gui": "italic" })
call s:h("jsDocType", { "fg": s:comment_grey, "gui": "italic" })
call s:h("jsDocTypeNoParam", { "fg": s:comment_grey, "gui": "italic" })
call s:h("jsExport", { "fg": s:cyan })
call s:h("jsExportDefault", { "fg": s:cyan })
call s:h("jsExtendsKeyword", { "fg": s:purple, "gui": "italic" })
call s:h("jsFrom", { "fg": s:purple, "gui": "italic" })
call s:h("jsFuncCall", { "fg": s:blue })
call s:h("jsFuncName", { "fg": s:blue })
call s:h("jsFuncArgs", { "fg": s:white })
call s:h("jsFunction", { "fg": s:blue })
call s:h("jsGenerator", { "fg": s:purple })
call s:h("jsGlobalObjects", { "fg": s:dark_yellow })
call s:h("jsImport", { "fg": s:cyan, "gui": "italic" })
call s:h("jsModuleAs", { "fg": s:cyan })
call s:h("jsModuleWords", { "fg": s:cyan })
call s:h("jsModules", { "fg": s:cyan })
call s:h("jsNull", { "fg": s:red })
call s:h("jsOperator", { "fg": s:cyan })
call s:h("jsStorageClass", { "fg": s:purple })
call s:h("jsSuper", { "fg": s:blue })
call s:h("jsTemplateBraces", { "fg": s:yellow })
call s:h("jsTemplateVar", { "fg": s:green })
call s:h("jsThis", { "fg": s:cyan, "gui": "italic" })
call s:h("jsUndefined", { "fg": s:yellow })
call s:h("jsBrackets", { "fg": s:paren_yellow })
call s:h("jsBraces", { "fg": s:paren_yellow })
call s:h("jsFuncBraces", { "fg": s:paren_yellow })
call s:h("jsClassBraces", { "fg": s:paren_yellow })
call s:h("jsObjectBraces", { "fg": s:paren_yellow })
call s:h("jsDestructuringBraces", { "fg": s:paren_yellow })
call s:h("jsModuleBraces", { "fg": s:paren_yellow })
call s:h("jsIfElseBraces", { "fg": s:paren_yellow })
call s:h("jsParens", { "fg": s:paren_yellow })
call s:h("jsFuncParens", { "fg": s:paren_yellow })
call s:h("jsNoise", { "fg": s:cyan })
call s:h("jsDot", { "fg": s:purple })
call s:h("jsTernaryIfOperator", { "fg": s:cyan })

" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:purple })
call s:h("javascriptClassExtends", { "fg": s:purple })
call s:h("javascriptClassKeyword", { "fg": s:purple })
call s:h("javascriptDocNotation", { "fg": s:purple })
call s:h("javascriptDocParamName", { "fg": s:blue })
call s:h("javascriptDocTags", { "fg": s:purple })
call s:h("javascriptEndColons", { "fg": s:white })
call s:h("javascriptExport", { "fg": s:purple })
call s:h("javascriptFuncArg", { "fg": s:white })
call s:h("javascriptFuncKeyword", { "fg": s:purple })
call s:h("javascriptIdentifier", { "fg": s:red })
call s:h("javascriptImport", { "fg": s:purple })
call s:h("javascriptMethodName", { "fg": s:white })
call s:h("javascriptObjectLabel", { "fg": s:white })
call s:h("javascriptOpSymbol", { "fg": s:cyan })
call s:h("javascriptOpSymbols", { "fg": s:cyan })
call s:h("javascriptPropertyName", { "fg": s:green })
call s:h("javascriptTemplateSB", { "fg": s:dark_red })
call s:h("javascriptVariable", { "fg": s:purple })


" Typescript
call s:h("typescriptReserved", { "fg": s:purple })
call s:h("typescriptStorageClass", { "fg": s:purple })
call s:h("typescriptBraces", { "fg": s:paren_yellow })
call s:h("typescriptParens", { "fg": s:paren_yellow })
call s:h("typescriptTypeBracket", { "fg": s:paren_yellow })
call s:h("typescriptDecorators", { "fg": s:blue })
call s:h("typescriptOpSymbols", { "fg": s:light_blue })
call s:h("typescriptType", { "fg": s:light_blue })
call s:h("typescriptNull", { "fg": s:red })
call s:h("typescriptExceptions", { "fg": s:purple })
call s:h("typescriptInterfaceKeyword", { "fg": s:purple })
call s:h("typescriptInterfaceName", { "fg": s:light_blue })
call s:h("typescriptPredefinedType", { "fg": s:light_blue, "gui": "italic" })
call s:h("typescriptMember", { "fg": s:white })
call s:h("typescriptMemberOptionality", { "fg": s:cyan })
call s:h("typescriptTypeAnnotation", { "fg": s:cyan })
call s:h("typescriptImport", { "fg": s:purple })
call s:h("typescriptCastKeyword", { "fg": s:purple })
call s:h("typescriptTypeReference", { "fg": s:light_blue })
call s:h("typescriptVariable", { "fg": s:purple })
call s:h("typescriptVariableDeclaration", { "fg": s:cyan })
call s:h("typescriptAssign", { "fg": s:cyan })
call s:h("typescriptTypeBrackets", { "fg": s:cyan })
call s:h("typescriptAliasKeyword", { "fg": s:purple })
call s:h("typescriptUnion", { "fg": s:cyan })
call s:h("typescriptFuncTypeArrow", { "fg": s:dark_purple })
call s:h("typescriptFuncType", { "fg": s:white })
call s:h("typescriptArrowFunc", { "fg": s:dark_purple })
call s:h("typescriptArrowFuncArg", { "fg": s:white })
call s:h("typescriptCall", { "fg": s:white })
call s:h("typescriptBinaryOp", { "fg": s:cyan })
call s:h("typescriptObjectLabel", { "fg": s:white })
call s:h("typescriptExport", { "fg": s:cyan })
call s:h("typescriptDefault", { "fg": s:cyan })
call s:h("typescriptObjectColon", { "fg": s:cyan })
call s:h("typescriptIdentifierName", { "fg": s:dark_yellow })
call s:h("typescriptDOMEventMethod", { "fg": s:blue })
call s:h("typescriptResponseMethod", { "fg": s:blue })
call s:h("typescriptCacheMethod", { "fg": s:blue })
call s:h("typescriptBoolean", { "fg": s:purple, "gui": "italic" })
call s:h("typescriptArrayMethod", { "fg": s:blue })
call s:h("typescriptTernaryOp", { "fg": s:cyan })
call s:h("typescriptDOMFormProp", { "fg": s:white, "gui": "italic" })
call s:h("typescriptMappedIn", { "fg": s:purple })
call s:h("typescriptTypeQuery", { "fg": s:purple })
call s:h("typescriptAsyncFuncKeyword", { "fg": s:purple, "gui": "italic" })
call s:h("typescriptTry", { "fg": s:purple })
call s:h("typescriptConstraint", { "fg": s:purple })
call s:h("typescriptTypeParameter", { "fg": s:light_blue })
call s:h("typescriptStringMethod", { "fg": s:blue })
call s:h("typescriptES6SetMethod", { "fg": s:blue })

" A few weird highlights
call s:h("typescriptServiceWorkerMethod", { "fg": s:white })
call s:h("typescriptFileReaderProp", { "fg": s:white })
call s:h("typescriptPaymentResponseProp", { "fg": s:white })
call s:h("typescriptRequestProp", { "fg": s:white })


call s:h("styledTypescriptPrefix", { "fg": s:cyan })
call s:h("styledAmpersand", { "fg": s:orange })
call s:h("styledPrefix", { "fg": s:cyan })


" TSX

call s:h("tsxTag", { "fg": s:light_blue })
call s:h("tsxCloseTag", { "fg": s:light_blue })
call s:h("tsxTagName", { "fg": s:cyan })
call s:h("tsxCloseString", { "fg": s:cyan })
call s:h("tsxAttrib", { "fg": s:dark_yellow })
call s:h("tsxEqual", { "fg": s:orange })
call s:h("tsxAttributeBraces", { "fg": s:paren_yellow })
call s:h("tsxIntrinsicTagName", { "fg": s:cyan })


" CSS

call s:h("cssPositioningProp", { "fg": s:dark_white })
call s:h("cssDimensionProp", { "fg": s:dark_white })
call s:h("cssBoxProp", { "fg": s:dark_white })
call s:h("cssBackgroundProp", { "fg": s:dark_white })
call s:h("cssTextProp", { "fg": s:dark_white })
call s:h("cssBorderProp", { "fg": s:dark_white })
call s:h("cssUIProp", { "fg": s:dark_white })
call s:h("cssFontProp", { "fg": s:dark_white })
call s:h("cssBraces", { "fg": s:paren_yellow })
call s:h("cssSelectorOp", { "fg": s:cyan })
call s:h("cssTagName", { "fg": s:red })
call s:h("cssPseudoClassId", { "fg": s:dark_orange })


" GraphQL
call s:h("graphqlStructure", { "fg": s:purple })
call s:h("graphqlType", { "fg": s:light_blue })


" JSON

call s:h("jsonBraces", { "fg": s:paren_yellow })
call s:h("jsonQuote", { "fg": s:purple })
call s:h("jsonKeywordMatch", { "fg": s:cyan })
call s:h("jsonNoise", { "fg": s:cyan })


" Python
call s:h("pythonInclude", { "fg": s:purple })
call s:h("pythonStatement", { "fg": s:purple })
call s:h("pythonSelf", { "fg": s:light_blue })
call s:h("pythonFunction", { "fg": s:blue })
call s:h("pythonBuiltinObj", { "fg": s:purple })
call s:h("pythonBuiltinType", { "fg": s:light_blue })
call s:h("pythonClass", { "fg": s:dark_yellow })
call s:h("pythonClassParameters", { "fg": s:white })
call s:h("pythonBrackets", { "fg": s:paren_yellow })
call s:h("pythonParam", { "fg": s:cyan })
call s:h("pythonExtraOperator", { "fg": s:cyan })
call s:h("pythonDot", { "fg": s:cyan })
call s:h("pythonClassTag", { "fg": s:orange })


" Git
call s:h("gitcommitSummary", { "fg": s:white })


" Markdown
call s:h("mkdHeading", { "fg": s:comment_grey, "gui": "bold" })
call s:h("mkdListItem", { "fg": s:orange })


" XML
call s:h("xmlAttrib", { "fg": s:dark_yellow })
call s:h("xmlTagName", { "fg": s:cyan })
call s:h("xmlEndTag", { "fg": s:cyan })
call s:h("xmlEqual", { "fg": s:orange })


" HTML
call s:h("htmlBold", { "gui": "bold" })


" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
call s:h("GitGutterAdd", { "fg": s:green })
call s:h("GitGutterChange", { "fg": s:yellow })
call s:h("GitGutterDelete", { "fg": s:red })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

call s:h("lCursor", { "bg": s:search_result })

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
