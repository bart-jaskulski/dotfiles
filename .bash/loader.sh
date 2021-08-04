#!/usr/bin/env bash

source $BASH_IT/helpers.sh
source $BASH_IT/log.sh

# Load enabled aliases, completion, plugins
for aliases in $BASH_IT/aliases/*.bash; do
    if [ -e $aliases ]; then
        source "$aliases"
    fi
done

for plugins in $BASH_IT/plugins/*.bash; do
    if [ -e $plugins ]; then
        source "$plugins"
    fi
done

for completions in $BASH_IT/completions/*.bash; do
    if [ -e $completions ]; then
        source "$completions"
    fi
done

# Load theme
# Load colors and helpers first so they can be used in base theme
if [[ "${THEME}" != "false" ]]; then
	source "${BASH_IT}/themes/colors.theme.bash"
	source "${BASH_IT}/themes/githelpers.theme.bash"
	source "${BASH_IT}/themes/base.theme.bash"

	source "$BASH_IT/themes/simple.theme.bash"
fi
