#!/bin/sh

if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    echo "Launching KDE autostart apps..."

    # Get rid of Plasma's desktop if it's active
    wmctrl -c Plasma
else
    echo "Launching i3 autostart apps..."

    # Dunst for notifications
    dunst

    # Network manager applet
    nm-applet
fi
