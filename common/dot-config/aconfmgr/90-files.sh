# File management and system setup files

CopyFile /etc/pacman.conf

CreateFile /etc/subuid- > /dev/null

CreateFile /etc/subgid- > /dev/null

RemoveFile /etc/subuid-

RemoveFile /etc/subgid-

CopyFile /etc/sudoers

CreateLink /usr/bin/sass ../lib/node_modules/sass/sass.js

CreateLink /usr/bin/vi /usr/bin/vim

SetFileProperty /usr/bin/groupmems group groups

SetFileProperty /usr/bin/groupmems mode 2750

SetFileProperty /usr/lib/utempter/utempter group utmp

SetFileProperty /usr/lib/utempter/utempter mode 2755

SetFileProperty /etc/sudoers mode 644
