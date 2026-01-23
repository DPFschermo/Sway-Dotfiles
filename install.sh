#!/usr/bin/env bash

```bash
echo "⚠️ After installation, log out and select 'Sway' from your login manager."

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

# --------------------------
# Check internet
# --------------------------

check_internet() {
	if ping -c 1 1.1.1.1 >/dev/null 2>&1; then
		echo "🌐 Internet connection detected"
	else
		echo "❌ No internet connection"
		echo "Please connect to the internet and rerun the script"
		exit 1
	fi
}

check_internet

COMMON_PKGS=(
	sway waybar wofi foot
	grim slurp wl-clipboard
)

AUDIO_PKGS=()
NET_PKGS=()

install_packages() {
	case "$ID" in
		debian|ubuntu|kali|mint)
   AUDIO_PKGS=(pipewire wireplumber pipewire-audio)
   NET_PKGS=(network-manager)
			echo "using apt"
			sudo apt update
			sudo apt install -y "${COMMON_PKGS[@]}" "${AUDIO_PKGS[@]}" "${NET_PKGS[@]}"
			;;

		arch|manjaro|cachyos|steamos)
			AUDIO_PKGS=(pipewire pipewire-pulse wireplumber)
   NET_PKGS=(networkmanager)
			echo "using pacman"
			sudo pacman -Sy --needed "${COMMON_PKGS[@]}" "${AUDIO_PKGS[@]}" "${NET_PKGS[@]}"
			;;
		
		void)
			AUDIO_PKGS=(pipewire pipewire-pulse wireplumber)
   NET_PKGS=(NetworkManager)
			echo "using xbps"
		 sudo xbps-install -Sy "${COMMON_PKGS[@]}" "${AUDIO_PKGS[@]}" "${NET_PKGS[@]}"
			;;

		gentoo)
	echo "Detected Gentoo"
	echo "Installing packages via emerge (this may take time)"
	sudo emerge --ask \
		sway waybar wofi foot \
		grim slurp wl-clipboard \
		pipewire wireplumber \
		networkmanager
	;;

		*)
			echo "Unsupported distro: $ID"
			echo "please install packages manually"
			return 1
			;;
	esac
}

if ! command -v nmcli >/dev/null; then
	echo "NetworkManager not detected, installing it"
else
	echo "NetworkManager already installed"
fi
		       	
echo "installing dependencies..."
install_packages

enable_services() {
	case "$ID" in
		debian|ubuntu|kali|mint|arch|manjaro|cachyos|steamos)
			echo "Enabling services (systemd)"
			sudo systemctl enable NetworkManager
			systemctl --user enable pipewire wireplumber || true
			;;

		void)
			echo "Enabling services (runit)"
			sudo ln -sf /etc/sv/NetworkManager /var/service
			;;

		gentoo)
			echo "Enabling services (OpenRC)"
			sudo rc-update add NetworkManager default
			;;
	esac
}

enable_services

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

[ "$missing" -eq 1 ] && echo "some dependencies are missing"

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


