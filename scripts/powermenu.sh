#!/bin/bash

choice=$(printf "󰐥 Shutdown\n Reboot\n Suspend\n󰍃 Logout" | \
	wofi --dmenu --width 250 --lines 4 --prompt "Power")
case "$choice" in
	*Shutdown) systemctl poweroff ;;
	*Reboot) systemctl reboot ;;
	*Suspend) systemctl suspend ;;
	*Logout) swaymsg exit ;;

esac 
