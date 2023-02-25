#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
#     # if not found, launch a new one
#     eval `dbus-launch --sh-syntax --exit-with-session`
#     echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
# fi

redshift -o &

dunst &

xset r rate 300 50

session=${1:-i3}

if [ "$session" = "dwm" ]; then
  while xsetroot -name "$(~/Scripts/tmux-battery) | $(date "+%d.%m (%a), %R")"
  do
    sleep 1m
  done &
fi

case $session in
  i3) exec i3;;
  dwm) exec dwm 2>~/.dmw-errors;;
  * ) echo "Unknown session";;
esac
