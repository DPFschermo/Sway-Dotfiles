#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.config/sway/.current_wallpaper"

chosen=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Wallpaper")

[ -z "$chosen" ] && exit

echo "$WALLPAPER_DIR/$chosen" > "$STATE_FILE"

swaymsg output "*" bg "$WALLPAPER_DIR/$chosen" fill
