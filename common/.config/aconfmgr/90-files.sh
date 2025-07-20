# File management and system setup files
CopyFile /etc/pacman.conf

CreateFile /etc/subgid- > /dev/null

CreateFile /etc/subuid- > /dev/null

CopyFile /etc/sudoers

CreateLink /usr/bin/sass ../lib/node_modules/sass/sass.js

CreateLink /usr/bin/vi /usr/bin/vim

SetFileProperty /usr/bin/groupmems group groups

SetFileProperty /usr/bin/groupmems mode 2750

SetFileProperty /usr/lib/utempter/utempter group utmp

SetFileProperty /usr/lib/utempter/utempter mode 2755
