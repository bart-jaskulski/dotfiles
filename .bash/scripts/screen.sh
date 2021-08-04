#!/bin/bash

IMAGE="$HOME/Pictures/screenshots/screen-$(date --iso-8601=seconds).jpg"
import "$IMAGE" -strip
notify-send --expire-time=1000 --icon="$IMAGE" "Screenshot taken."
# xclip -in -selection clipboard -target image/jpeg < $IMAGE
exit 0
