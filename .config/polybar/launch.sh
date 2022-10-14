#!/usr/bin/env bash

# WARN: This is very fragile, it relies on the same monitor setup

dir="$HOME/.config/polybar"
style="forest"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch main bar
polybar -q main -c "$dir/$style/config.ini" &
# Launch side bar
polybar -q side -c "$dir/$style/config.ini" &
