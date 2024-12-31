#!/bin/bash
sct 3500; # Take care of blue light
xset r rate 250 30
xsetroot -solid '#202020'

# Notifications daemon
tiramisu -o "#summary #body" | while read -r NOTIFY; do herbe "$NOTIFY"; done &
xbanish -st5 &
sxhkd &
# swhks &
# swhkd
slstatus &
hydroxide serve &

# exec 2bwm 2>~/.2bwm-errors
# exec sowm 2>~/.sowm-errors
exec dwm 2>~/.dwm-errors
# exec i3 2>~/.i3-errors
