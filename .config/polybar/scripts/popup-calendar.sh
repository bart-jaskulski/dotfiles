show_popup() {
  yad --calendar \
      --undecorated --fixed --close-on-unfocus \
      --posy=38 --posx=815 --no-buttons --borders=0 \
      --title="yad-calendar" \
      > /dev/null &
}

case "$1" in
  --popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
       killall -q yad
    else
       show_popup
    fi ;;
  *)
    echo $(date +"%H:%M") ;;
esac

unset -f show_popup
