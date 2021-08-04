if ls --color -d . &> /dev/null
then
  alias ls="ls --color=auto"
elif ls -G -d . &> /dev/null
then
  alias ls='ls -G'        # Compact view, show colors
fi

# List directory contents
alias sl=ls
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

alias _="sudo"

# Shortcuts to edit startup files
alias vbrc="vim ~/.bashrc"
alias vbpf="vim ~/.bash_profile"

# colored grep
# Need to check an existing file for a pattern that will be found to ensure
# that the check works when on an OS that supports the color option
if grep --color=auto "a" "${BASH_IT}/"*.md &> /dev/null
then
  alias grep='grep --color=auto'
fi

if which gshuf &> /dev/null
then
  alias shuf=gshuf
fi

alias c='clear'
alias k='clear'
alias cls='clear'

alias q='exit'
alias e='exit'
alias x='exit'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Shell History
alias h='history'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# Directory
alias md='mkdir -p'
alias rd='rmdir'

# Shorten extract
alias xt="extract"

# sudo editors
alias svim="sudo nvim"
alias v="nvim"
alias v.="nvim ./"
alias vim="nvim"
alias vh="nvim -c \":h | only\""

alias r='ranger'

alias shut='docker_kill && shutdown now'
alias open='xdg-open'

alias pc='pass -c'

# Display whatever file is regular file or folder
catt() {
  for i in "$@"; do
    if [ -d "$i" ]; then
      ls "$i"
    else
      cat "$i"
    fi
  done
}
