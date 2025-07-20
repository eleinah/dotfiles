#!/bin/bash

set -euo pipefail

show_usage() {
	echo "Usage: $0 [mainstation|travelstation]"
	echo "  mainstation  - Sync desktop dotfiles"
	echo "  travelstation  - Sync laptop dotfiles"
	exit 1
}


if [ $# -eq 0 ]; then
	echo "No machine type specified."
	echo ""
	show_usage
elif [ "$1" = "mainstation" ] || [ "$1" = "travelstation" ]; then
	MACHINE_TYPE="$1"
elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	show_usage
else
	echo "Error: Invalid Option '$1'"
	show_usage
fi

echo "<=== Syncing dotfiles ===>"
cd "$dots"
git commit -am "Update dotfiles"
git pull --rebase
git push
stow -v -t "$HOME" -R common
stow -v -t "$HOME" -R "$MACHINE_TYPE"
