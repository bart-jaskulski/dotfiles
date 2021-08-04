monitor() {
    case $1 in
        on)
            xrandr --output HDMI-1 --auto --right-of eDP-1
	    exec "$HOME/.fehbg"
        ;;
        off)
            xrandr --output HDMI-1 --off
        ;;
    esac
}
