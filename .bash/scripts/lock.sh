#!/usr/bin/bash
    import -window root /tmp/lock.png
    convert -filter Gaussian -blur 0x4 /tmp/lock.png /tmp/lock.png
    i3lock -ui /tmp/lock.png
