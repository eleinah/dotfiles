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

if [ -z "${dots:-}" ]; then
	echo "Error!: 'dots' env var is not set. Check possible areas causing issue:"
	echo "  - ~/.zprofile"
	echo "  - ~/.zshrc"
	echo "  - ~/.config/shell/vars"
	exit 1
fi

echo "<=== Syncing dotfiles ===>"
cd "$dots"
echo "Please review 'git status' and 'git diff' first:"
sleep 2
git status
read -rp "Continue? (y/n): " STATUS_CONFIRM
[[ "$STATUS_CONFIRM" == "y" || "$STATUS_CONFIRM" == "Y" ]] || exit 1
sleep 2
git diff
read -rp "Continue? (y/n): " DIFF_CONFIRM
[[ "$DIFF_CONFIRM" == "y" || "$DIFF_CONFIRM" == "Y" ]] || exit 1
read -rp "Please enter a commit message: " COMMIT_MSG
git add .
git commit -m "$COMMIT_MSG"
git pull --rebase
git push
stow -v -t "$HOME" -R common --dotfiles
stow -v -t "$HOME" -R "$MACHINE_TYPE" --dotfiles
echo "<=== Dotfiles synced ===>"
