# Only supports the Arch at the moment.
if command -v pacman &>/dev/null && pacman -Q autojump &>/dev/null ; then
  . "$(pacman -Ql autojump | grep autojump.sh | cut -d' ' -f2)"
fi
