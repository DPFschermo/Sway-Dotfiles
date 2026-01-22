#!/usr/bin/env bash

set -e

CONFIG_DIR="$HOME/.config"

echo "Uninstalling dotfiles..."
echo "Config directory: $CONFIG_DIR"

remove_if_exists() {
	if [ -e "CONFIG_DIR/$1" ]; then
		echo "removing $1"
		rm -rf "$CONFIG_DIR/$1"
	else
		echo " $1 not found, skipping"
	fi
}

remove_if_exists sway
remove_if_exists foot
remove_if_exists waybar
remove_if_exists wofi
remove_if_exists scripts

echo "Dotfiles removed"

LATEST_BACKUP=$(ls -dt "$CONFIG_DIR"/.config_backup_* 2>/dev/null | head -n 1)

if [ -n "$LATEST_BACKUP" ]; then
	echo "Found backup: $LATEST_BACKUP"
	read -rp "Restore this backup? [y/N]: " choice

	if [ "$choice" =~ ^[Yy]$ ]; then
		echo "Restoring backup..."
		cp -r "$LATEST_BACKUP"/* "$CONFIG_DIR/"
		echo "backup restored!"
	else
		echo "backup not restored :("
	fi
else
	echo "no backups found"
fi

echo "uninstall complete"
