#!/bin/bash
bwp

dunstmerge

xrdb -merge ~/.Xresources

#xsetroot -name "fsignal:1"

killall -v -USR1 st cava
killall -v dunst
killall python3
killall xeyes && xeyes +shape -outline "$(mondo -c bg)" &

dunst -q &

#xsetroot -name "fsignal:1"

filesort &
killall xob
tail -f /tmp/xobb | xob -m 3000 -s backlight &

volume-watcher | xob &
mic-watcher | xob -s mic &
