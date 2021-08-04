function mkcd ()
{
    # about 'make one or more directories and cd into the last one'
    # param 'one or more directories to create'
    # example '$ mkcd foo'
    # example '$ mkcd /tmp/img/photos/large'
    # example '$ mkcd foo foo1 foo2 fooN'
    # example '$ mkcd /tmp/img/photos/large /tmp/img/photos/self /tmp/img/photos/Beijing'
    # group 'base'
    mkdir -p -- "$@" && eval cd -- "\"\$$#\""
}

function lsgrep ()
{
    # about 'search through directory contents with grep'
    # group 'base'
    ls | grep "$*"
}

function command_exists ()
{
    # about 'checks for existence of a command'
    # param '1: command to check'
    # example '$ command_exists ls && echo exists'
    # group 'base'
    type "$1" &> /dev/null ;
}
