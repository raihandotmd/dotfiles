#!/bin/bash
sleep 0.5
xrandr --output DisplayPort-0 --mode 1920x1080 --pos 0x-1080 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal

# set wallpaper
feh --bg-scale ~/.config/feh/personal-wallpaper.png
