#!/bin/bash

sct 5000; # Take care of blue light
xset r rate 250 30
xsetroot -solid '#202020'

# Notifications daemon
tiramisu -o "#summary\n#body" | while read -r NOTIFY; do herbe "$NOTIFY"; done &
slstatus &
xbanish -st5 &
./Downloads/activitywatch-v0.12.2-linux-x86_64/activitywatch/aw-qt --no-gui &

exec dwm 2>~/.dwm-errors
# exec i3 2>~/.i3-errors
