#!/bin/sh

zscroll -l 35 \
        --delay 0.5 \
        --scroll-padding "  " \
        --match-command "`dirname $0`/spotify-status.sh" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "`dirname $0`/spotify-playing.sh" &

wait
