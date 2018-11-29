#!/bin/sh
# Give rofi menu with a list of all unicode characters to copy.
# Shows the selected character in dunst if running.
# This script is copied from Luke Smith's voidrice but modified to run rofi.
# https://github.com/LukeSmithxyz/voidrice/blob/master/.scripts/i3cmds/dmenuunicode

# Must have xclip installed to even show menu.
xclip -h >/dev/null || exit

chosen=$(grep -v "#" ~/dotfiles/emoji | rofi -dmenu -i)

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
pgrep -x dunst >/dev/null && notify-send "'$c' copied to clipboard."

s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
echo "$s" | tr -d '\n' | xclip
pgrep -x dunst >/dev/null && notify-send "'$s' copied to primary."

