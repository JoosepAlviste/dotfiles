#!/bin/bash

# Open a Rofi selection with various power options.
# Needs a file containing options to choose from at $OPTIONS_FILE.

OPTIONS_FILE=~/.config/scripts/rofi-scripts-collection/dmenu-i3exit
PROMPT="Power"

res=$(rofi -dmenu < $OPTIONS_FILE -p $PROMPT)

if [ "$res" = "logout" ]; then
    i3-msg exit
fi
if [ "$res" = "restart" ]; then
    reboot
fi
if [ "$res" = "shutdown" ]; then
    poweroff
fi
if [ "$res" = "lock screen" ]; then
    betterlockscreen -l dim
fi

exit 0

