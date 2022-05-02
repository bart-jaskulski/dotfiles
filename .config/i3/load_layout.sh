#!/bin/bash

# Append PhpStorm to workspace 2 and 3
i3-msg "workspace 3; append_layout ./.config/i3/workspace-term.json"
i3-msg "workspace 2; append_layout ~/.config/i3/workspace-dev.json"

# Run the PhpStorm to fill placeholders
bash -c ~/bin/PhpStorm/bin/phpstorm.sh
