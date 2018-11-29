#!/bin/bash
OUTPUT=$(pactl list short sinks | cut  -f 2 | rofi -dmenu -p "Output")
pacmd set-default-sink "$OUTPUT" >/dev/null 2>&1

for playing in $(pacmd list-sink-inputs | awk '$1 == "index:" {print $2}'); do
    pacmd move-sink-input "$playing" "$OUTPUT" >/dev/null 2>&1
done

