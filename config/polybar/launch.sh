#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar when NOT in KDE plasma (Plasma already has a bar)
if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    # Bar is the name set in the polybar config, so if you change it, you have to change it here too.
    polybar bar1 &
    polybar bar2 &

    echo "Bars launched..."
else
    echo "Did not launch bars -- in KDE"
fi
