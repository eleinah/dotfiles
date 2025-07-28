#!/bin/bash
# pre.sh

set -uo pipefail

echo "<=== Starting pre-install ===>"

echo ":: Checking network connectivity..."
if ping -c 1 archlinux.org &>/dev/null; then
	echo "Network OK"
else
	echo "No network connectivity. Please connect before running this."
	exit 1
fi

echo ":: Setting timedatectl..."
timedatectl set-ntp true

echo ":: Starting disk operations..."
lsblk
read -rp "Target disk: (i.e. /dev/nvme0n1) " DISK

echo "WARNING: This will erase all data on $DISK !"
read -rp "Type (y)es to continue: " CONFIRM
# [[ "$CONFIRM" == "y" || "$CONFIRM" == "yes" ]] || exit 1
[[ "$CONFIRM" =~ ^([yY]|[yY][eE][sS])$ ]] || exit 1

echo ":: Wiping signatures..."
wipefs -a "$DISK"

echo ":: Starting partitioning..."
sfdisk "$DISK" <<EOF
label: gpt
,1024MiB,U
,4096MiB,S
,,L
EOF

partprobe "$DISK"

EFI="${DISK}p1"
SWAP="${DISK}p2"
ROOT="${DISK}p3"

mkfs.fat -F 32 "$EFI"
mkswap "$SWAP"
mkfs.btrfs -f "$ROOT"

mount "$ROOT" /mnt
mkdir -p /mnt/boot
mount "$EFI" /mnt/boot
swapon "$SWAP"

echo ":: Downloading setup-chroot.sh..."
mkdir -p /mnt/root
curl -fsSL "https://raw.githubusercontent.com/eleinah/dotfiles/refs/heads/main/common/dot-config/scripts/arch/chroot-setup.sh" -o /mnt/root/chroot-setup.sh
chmod +x /mnt/root/chroot-setup.sh

echo ":: Starting base install..."
pacstrap -K /mnt base linux linux-firmware intel-ucode btrfs-progs sof-firmware vim man-db man-pages texinfo curl dhcpcd grep grub efibootmgr iwd kitty-terminfo nmap polkit python sudo systemd tmux zsh

genfstab -U /mnt >>/mnt/etc/fstab

echo ":: chroot'ing into /mnt..."
arch-chroot /mnt /root/chroot-setup.sh

echo ":: Unmounting..."
umount -R /mnt

echo "<=== Pre-install complete! Reboot and run post.sh ===>"
