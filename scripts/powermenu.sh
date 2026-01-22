#!/bin/bash

choice=$(printf "⏻ Shutdown\n🔁 Reboot\n⏾ Suspend\n🚪 Logout" | \
  wofi --dmenu --width 250 --lines 4)

poweroff_cmd() {
  if command -v loginctl >/dev/null 2>&1; then
    loginctl poweroff
  else
    poweroff
  fi
}

reboot_cmd() {
  if command -v loginctl >/dev/null 2>&1; then
    loginctl reboot
  else
    reboot
  fi
}

suspend_cmd() {
  if command -v loginctl >/dev/null 2>&1; then
    loginctl suspend
  else
    echo "⚠️ Suspend not available"
  fi
}

case "$choice" in
  *Shutdown) poweroff_cmd ;;
  *Reboot) reboot_cmd ;;
  *Suspend) suspend_cmd ;;
  *Logout) swaymsg exit ;;
esac
