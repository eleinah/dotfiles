# File management and system setup files

CopyFile /etc/pacman.conf

CreateFile /etc/subuid- >/dev/null

CreateFile /etc/subgid- >/dev/null

RemoveFile /etc/subuid-

RemoveFile /etc/subgid-

CopyFile /etc/sudoers

CreateLink /usr/bin/sass ../lib/node_modules/sass/sass.js

CreateLink /usr/bin/vi /usr/bin/vim

SetFileProperty /usr/bin/groupmems group groups

SetFileProperty /usr/bin/groupmems mode 2750

SetFileProperty /etc/sudoers mode 644

CopyFile /etc/texmf/ls-R
CopyFile /etc/texmf/web2c/fmtutil.cnf
CopyFile /etc/texmf/web2c/updmap.cfg
CopyFile /usr/share/texmf-dist/ls-R
# Mon Aug  4 11:55:49 AM CDT 2025 - Extra files


RemoveFile /usr/bin/vi
RemoveFile /usr/bin/sass
RemoveFile /usr/bin


# Mon Aug  4 11:55:49 AM CDT 2025 - Extra file properties


SetFileProperty /usr/bin/groupmems group ''
SetFileProperty /usr/bin/groupmems mode ''
