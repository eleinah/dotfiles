# Snapshots
IgnorePath '/.snapshots/*'

# Boot
IgnorePath '/boot/*'

# var dir
IgnorePath '/var/*'

# GPG and GNUPG sockets (runtime, not portable)
IgnorePath '/etc/pacman.d/gnupg/*'

# host-specific etc stuff
IgnorePath '/etc/hostname'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/hosts'
IgnorePath '/etc/resolv.conf'
IgnorePath '/etc/fstab'
IgnorePath '/etc/locale.gen'
IgnorePath '/etc/locale.conf'
IgnorePath '/etc/vconsole.conf'
IgnorePath '/etc/X11/xorg.conf*'
IgnorePath '/etc/mkinitcpio.conf'
IgnorePath '/etc/adjtime'
IgnorePath '/etc/group'
IgnorePath '/etc/group-'
IgnorePath '/etc/subgid'
IgnorePath '/etc/subuid'
IgnorePath '/etc/subgid-'
IgnorePath '/etc/subuid-'
IgnorePath '/etc/mkinitcpio.d'
IgnorePath '/etc/ld.so.cache'
IgnorePath '/etc/sudoers.pacnew'
IgnorePath '/etc/.pwd.lock'
IgnorePath '/etc/.updated'
IgnorePath '/etc/localtime'
IgnorePath '/etc/os-release'
IgnorePath '/etc/pacman.d/*'
IgnorePath '/etc/shells'
IgnorePath '/etc/systemd/**'
IgnorePath '/etc/fonts/**'
IgnorePath '/usr/share/applications/mimeinfo.cache'
IgnorePath '/usr/share/fonts/**'
IgnorePath '/usr/share/info/dir'
IgnorePath '/usr/share/icons/**/icon-theme.cache'
IgnorePath '/usr/share/vim/vimfiles/doc/tags'
IgnorePath '/etc/snapper/**'
IgnorePath '/etc/conf.d/snapper'
IgnorePath '/usr/share/glib-2.0/*'
IgnorePath '/usr/lib32/**'
IgnorePath '/usr/lib/**'

# home stuff, just to be safe
IgnorePath '/home/*'

# SSH host keys
IgnorePath '/etc/ssh/ssh_host_*'

# Secrets/tokens
IgnorePath '/etc/NetworkManager/system-connections/*'
IgnorePath '/etc/wpa_supplicant/*.conf'
IgnorePath '/etc/systemd/system/*.service.d/'
IgnorePath '/etc/tower/SECRET_KEY'
# IgnorePath '$HOME/.local/share/keyrings'
IgnorePath '/etc/shadow*'
IgnorePath '/etc/passwd*'
IgnorePath '/etc/gshadow*'

# Temporary files, locks, runtime
IgnorePath '/tmp/*'
IgnorePath '/run/*'

# Ignore SSL/mime/cert stuff
IgnorePath '/etc/ssl/certs/*'
IgnorePath '/etc/ca-certificates/extracted/*'
IgnorePath '/etc/ca-certificates/update.d/*'
IgnorePath '/etc/ca-certificates/trust-source/*'
IgnorePath '/usr/share/mime/*'

# Ignore Spotify
IgnorePath '/opt/spotify/*'

# Ignore some bin stuff
IgnorePath '/usr/bin/**'
