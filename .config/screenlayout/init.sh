#!/bin/bash
xrandr --auto
if xrandr --listmonitors | grep 'Monitors: 1'; then
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off
elif xrandr --listmonitors | grep '3840/'; then
	#xrandr --output eDP1 --primary --mode 1920x1080 --pos 3840x1080 --rotate normal --output DP1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP2 --off --output VIRTUAL1 --off
	xrandr --output DP1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP1 --off --output DP2 --off --output VIRTUAL1 --off
elif xrandr --listmonitors | grep 'Monitors: 3'; then
    xrandr --output eDP1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP2 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off
fi

