![License](https://img.shields.io/badge/license-MIT-green)

Never ending project, made from a "begginer", feel free to give me advices

Minimal, clean and GPU-friendly Sway dotfiles with Waybar, Wofi, PipeWire, and a custom install script that works across multiple Linux distributions.

Designed to be:
	•	⚡ Fast
	•	🧊 Clean
	•	🔋 Laptop-friendly
	•	🧩 Easy to install & remove

⸻

✨ Features
	•	Sway window manager (Wayland)
	•	Waybar with:
	•	Network
	•	Battery
	•	CPU / Memory
	•	Power menu (Wofi)
	•	Wallpaper switcher
	•	Wofi menus (power & wallpaper)
	•	PipeWire audio (modern, low-latency)
	•	NetworkManager support
	•	GPU-friendly animations
	•	Automatic backup of existing configs
	•	One-script install (multi-distro)

The install script automatically detects your distro:
	•	✅ Debian / Ubuntu / Linux Mint / Kali
	•	✅ Arch / Manjaro / CachyOS / SteamOS
	•	✅ Void Linux (runit)
	•	✅ Gentoo (OpenRC)

Other distros may work, but are not officially supported.

⸻

📦 Dependencies Installed Automatically

Core
	•	sway
	•	waybar
	•	wofi
	•	foot
	•	grim
	•	slurp
	•	wl-clipboard

Audio
	•	pipewire
	•	pipewire-pulse
	•	wireplumber

Network
	•	NetworkManager

Installation: 
    git clone https://github.com/DPFschermo/Sway-Dotfiles.git
    cd Sway-Dotfiles
    chmod +x install.sh
    ./install.sh

After installation
	1.	Log out
	2.	Select Sway from your login manager
	3.	Log back in

Your existing configs are backed up automatically.

⸻

♻️ Backup Behavior

Before installing, existing configs are moved to:
~/.config_backup_YYYYMMDD_HHMMSS

🔁 Uninstall:

chmod +x uninstall.sh
./uninstall.sh

🛠️ Notes per Init System
	•	systemd
Services are enabled automatically using systemctl
	•	Void (runit)
Services are enabled via /var/service
	•	Gentoo (OpenRC)
Services are added using rc-update

No manual intervention required.

⸻

🧠 FAQ

❓ Will this remove my current desktop (Cinnamon, GNOME, etc.)?

No.
Sway is installed alongside your current desktop. You choose it at login.

❓ Does this require an internet connection?

Yes. Packages are installed from your distro repositories.

❓ Is this beginner-friendly?

Yes — but basic Linux knowledge is recommended.

⸻

🧑‍💻 Customization
	•	Sway config → ~/.config/sway/
	•	Waybar config → ~/.config/waybar/
	•	Scripts → ~/.config/scripts/

Feel free to fork and tweak!

⸻

Credits

Created by DPFschermo

⸻

MIT License 