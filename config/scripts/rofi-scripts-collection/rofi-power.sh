#!/bin/bash

# Open a Rofi selection with various power options.
# Needs a file containing options to choose from at $OPTIONS_FILE.

OPTIONS_FILE=~/.config/scripts/rofi-scripts-collection/dmenu-i3exit
PROMPT="Power"

res=$(rofi -dmenu < $OPTIONS_FILE -p $PROMPT -i)

if [ "$res" = "Logout" ]; then
    i3-msg exit
fi
if [ "$res" = "Restart" ]; then
    reboot
fi
if [ "$res" = "Shut Down" ]; then
    poweroff
fi
if [ "$res" = "Lock Screen" ]; then
    betterlockscreen -l dim
fi

exit 0

