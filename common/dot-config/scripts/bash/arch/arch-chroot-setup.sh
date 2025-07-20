#!/bin/bash

set -e

get_hostname() {
	while true; do
		read -rp "Enter a hostname: " HOST_INPUT
		if [ -n "$HOST_INPUT" ]; then
			break
		fi
		echo "Hostname required"
	done
}

echo ":: Setting localtime..."
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

echo ":: Generating /etc/adjtime..."
hwclock --systohc

echo ":: Setting localization..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo ":: Setting hostname..."
get_hostname
echo "$HOST_INPUT" > /etc/hostname

echo ":: Setting root password..."
passwd

echo ":: Installing GRUB..."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo ":: Generating GRUB config..."
grub-mkconfig -o /boot/grub/grub.cfg

echo ":: Creating user..."
read -rp "Enter a username: " USRNAME
useradd -m -G wheel,input -s /usr/bin/zsh "$USRNAME"

echo ":: Setting password for $USRNAME ..."
passwd "$USRNAME"
