#!/bin/bash
# post.sh
# -
# use after pre.sh 

set -euo pipefail

show_usage() {
	echo "Usage: $0 [mainstation|travelstation]"
	echo "  mainstation  - Deploy desktop config"
	echo "  travelstation  - Deploy laptop config"
	exit 1
}

check_network() {
	local retries=3
	for i in $(seq 1 $retries); do
		if ping -c 1 8.8.8.8 &> /dev/null; then
			return 0
		fi
		echo "Network check attempt $i/$retries failed, retrying..."
		sleep 2
	done
	echo "No network connectivity. Consider checking NetworkManager or running 'systemctl enable --now NetworkManager'"
	return 1
}

if [ $# -eq 0 ]; then
	echo "No machine type specified."
	echo ""
	show_usage
elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	show_usage
elif [ "$1" = "mainstation" ] || [ "$1" = "travelstation" ]; then
	MACHINE_TYPE="$1"
else
	echo "Error: Invalid Option '$1'"
	show_usage
fi

echo "<=== Starting post-install deployment ===>"

HOME="/home/ellie"

if [ ! -d "$HOME/workspace/github.com/eleinah" ]; then
	mkdir -p "$HOME/workspace/github.com/eleinah"
fi

GHWS="$HOME/workspace/github.com/eleinah"

echo ":: Checking network connectivity..."
check_network

echo ":: Running initial updates..."
sudo pacman -Syu --noconfirm

echo ":: Installing essential pkgs..."
sudo pacman -S --noconfirm git stow

echo ":: Installing dependencies for AUR..."
sudo pacman -S --noconfirm base-devel devtools

if ! command -v yay &> /dev/null; then
	echo ":: Installing yay..."
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si --noconfirm
	cd $HOME
	rm -rf /tmp/yay
fi

echo ":: Installing aconfmgr..."
yay -S --noconfirm --needed aconfmgr-git

echo ":: Cloning dotfiles repo..."
cd "$GHWS"
if [ ! -d "dotfiles" ]; then
	git clone https://github.com/eleinah/dotfiles.git
fi

echo ":: Deploying dotfiles for $MACHINE_TYPE ..."
cd dotfiles
if [ -f "$HOME/.zshrc" ]; then
	rm "$HOME/.zshrc"
fi
if [ -f "$HOME/.zprofile" ]; then
	rm "$HOME/.zprofile"
fi
stow -t ~ common
stow -t ~ "$MACHINE_TYPE"

echo ":: Applying aconfmgr..."
mkdir -p $HOME/.config/aconfmgr
cd $HOME/.config/aconfmgr
aconfmgr apply

echo "<=== Post-install complete! ===>"
