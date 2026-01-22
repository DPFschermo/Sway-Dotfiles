#!/usr/bin/env bash

set -e

# ----------------------------------------
# Detect OS
# ----------------------------------------
if [ -f /etc/os-release ]; then
	source /etc/os-release
	echo "Detected OS: $ID"
else
	echo "Cannot detect OS"
fi

COMMON_PKGS=(
	sway
	waybar
	wofi
	foot
	grim
	slurp
	wl-clipboard
)

install_packages() {
	case "$ID" in
		debian|ubuntu|kali|mint)
			echo "using apt"
			sudo apt update
			sudo apt install -y "${COMMON_PKGS[@]}"
			;;

		arch|manjaro|cachyos|steamos)
			echo "using pacman"
			sudo pacman -Sy --needed "${COMMON_PKGS[@]}"
			;;
		
		void)
		 echo "using xbps"
		 sudo xbps-install -Sy "${COMMON_PKGS[@]}"
			;;

		gentoo)
			echo "Detected Gentoo"
			echo "Installing packages via emerge (this may take time)"
			sudo emerge --ask \
				sway waybar wofi foot \
				grim slurp wl-clipboard
			;;

		*)
			echo "Unsupported distro: $ID"
			echo "please install packages manually"
			return 1
			;;
	esac
}
		       	
echo "installing dependencies..."
install_packages

# ---------------------------------------
# Check required programs
# ---------------------------------------
missing=0
check () {
	if ! command -v "$1" >/dev/null; then
		echo "$1 missing"
		missing=1
	fi
}

echo "checking dependencies"
check sway
check wofi
check foot
check waybar

[ "missing" -eq 1 ] && echo "some dependencies are missing"

# --------------------------------------
# Paths
# -------------------------------------
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing Sway dotfiles..."
echo "Backup dir: $BACKUP_DIR"

mkdir -p "$BACKUP_DIR"

backup_if_exists() {
	if [ -e "$CONFIG_DIR/$1" ]; then 
		echo "Backing up $1"
		mv "$CONFIG_DIR/$1" "$BACKUP_DIR/"
	fi
}

backup_if_exists sway
backup_if_exists waybar
backup_if_exists wofi
backup_if_exists foot
backup_if_exists scripts

echo "Copying new configs..."
cp -r sway waybar wofi foot scripts "$CONFIG_DIR/"

echo "Making scripts executable..."
chmod +x "$CONFIG_DIR/scripts/"*.sh

echo "Done!"
echo "Old configs saved in: $BACKUP_DIR"
echo "Reload sway or log out/in to apply changes"


