#!/bin/bash

set -euo pipefail

show_usage() {
	echo "Usage: $0 [mainstation|travelstation] (-v)"
	echo "  mainstation  - Sync desktop dotfiles"
	echo "  travelstation  - Sync laptop dotfiles"
	echo "  (-v)  - verbose Stow output"
	exit 1
}

get_commit_msg() {
	while true; do
		read -rp "Please enter a commit message: " COMMIT_MSG
		if [ -n "$COMMIT_MSG" ]; then
			break
		fi
		echo "Commit message required"
	done
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

if [ -z "${dots:-}" ]; then
	echo "Error!: 'dots' env var is not set. Check possible areas causing issue:"
	echo "  - ~/.zprofile"
	echo "  - ~/.zshrc"
	echo "  - ~/.config/shell/vars"
	exit 1
fi

echo "<=== Syncing dotfiles ===>"

cd "$dots"

if [ -n "$(git status --porcelain)" ]; then
	echo "Please review 'git status' and 'git diff' first:"
	sleep 1
	
	git status
	read -rp "Continue? (y/n): " STATUS_CONFIRM
	[[ "$STATUS_CONFIRM" =~ ^([yY]|[yY][eE][sS])$ ]] || exit 1
	sleep 1
	
	git diff
	read -rp "Continue? (y/n): " DIFF_CONFIRM
	[[ "$DIFF_CONFIRM" =~ ^([yY]|[yY][eE][sS])$ ]] || exit 1

	get_commit_msg
	git add .
	git commit -m "$COMMIT_MSG"
	git pull --rebase
	git push
else
	echo "Nothing to commit."
fi

if [ "${2:-}" = "-v" ] || [ "${2:-}" = "-V" ]; then
	stow -v -t "$HOME" -R common --dotfiles
	stow -v -t "$HOME" -R "$MACHINE_TYPE" --dotfiles
else
	stow -t "$HOME" -R common --dotfiles
	stow -t "$HOME" -R "$MACHINE_TYPE" --dotfiles
fi

echo "<=== Dotfiles synced ===>"
