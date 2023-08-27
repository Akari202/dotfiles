IMAGE=/tmp/i3lock.png
# WARN: I am using a fork of scrot that has blur built in, saving me the time of passing it to imagemagik
# scrot -B 5 -i ~/Downloads/util/dotfiles/i3lock/LockOverlay.png $IMAGE
scrot -B 5 $IMAGE
i3lock -i $IMAGE
