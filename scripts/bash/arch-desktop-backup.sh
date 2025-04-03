# Simple script to backup my whole Arch Linux desktop to my backup disk
#
# :3


### ROOT?!?!
if [ "$(id -u)" -ne 0 ]; then
	echo "Run this is as root silly goose!"
	exit 1
fi

SOURCE_PATH="/"
DEST_PATH="/mnt/backup"

### Ensure /dev/sda1 is mounted
if [ ! -d "$DEST_PATH" ]; then
	echo "/dev/sda1 is not mounted to $DEST_PATH !"
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
rsync "${OPTIONS[@]}" "$SOURCE_PATH" "$DEST_PATH"
