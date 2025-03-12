# Simple script to restore my whole Arch Linux desktop from my backup disk
#
# :3
#
# Three things are needed to run this!
# 1. Must be booted into an Arch live image
# 2. /mnt/restore and /mnt/backup must exist
# 3. Ensure the following:
#    > /dev/sda1 is mounted to /mnt/backup
#    > /dev/nvme0n1p3 is mounted to /mnt/restore


### ROOT?!?!
if [ "$(id -u)" -ne 0 ]; then
	echo "Run this is as root silly goose!"
	exit 1
fi

SOURCE_PATH="/mnt/backup"
DEST_PATH="/mnt/restore"

### Ensure /dev/sda1 is mounted
if [ ! -d "$SOURCE_PATH" ]; then
	echo "/dev/sda1 is not mounted to /mnt/backup !"
	exit 1
fi

### Ensure root partition is mounted
if [ ! -d "$DEST_PATH" ]; then
	echo "/dev/nvme0n1p3 is not mounted to /mnt/restore !"
	exit 1
fi

### Array for directory exclusions
EXCLUDES=(
	"/dev/**"
	"/proc/**"
	"/sys/**"
	"/tmp/**"
	"/run/**"
	"/mnt/**"
	"/media/**"
	"/lost+found"
	"/home/*/.cache/**"
	"/var/run/**"
	"/var/lock/**"
	"/var/tmp/**"
)

### Array for rsync options - for loop adds excluded directories
OPTIONS=("-aAXH" "--info=stats,progress2")
for EXCLUDE in "${EXCLUDES[@]}"; do
	OPTIONS+=("--exclude=$EXCLUDE")
done

### Finally, run the command!
rsync "${OPTIONS[@]}" "$SOURCE_PATH/" "$DEST_PATH"
