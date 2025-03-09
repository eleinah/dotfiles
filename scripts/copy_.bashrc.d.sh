# This script copies everything from ~/.bashrc.d/ to my FCOS hosts via scp

SOURCE_PATH="/home/$USER/git/dotfiles/.bashrc.d/"
DEST_PATH="~/"

HOSTS=(media bunker util)

for HOST in "${HOSTS[@]}"; do
    scp -r "$SOURCE_PATH" "$HOST:$DEST_PATH"
done
