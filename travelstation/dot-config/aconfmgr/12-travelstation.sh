AddPackage intel-media-driver                      # for hardware accelerated decoding
AddPackage --foreign evsieve                       # lenovo pen support
AddPackage iio-sensor-proxy                        # screen rotation detection and tablet mode
AddPackage power-profiles-daemon                   # laptop power saving modes
AddPackage dhcpcd                                  # for DHCP resolution
AddPackage iwd                                     # for Wi-Fi capabilities
AddPackage --foreign globalprotect-openconnect-git # A GUI for GlobalProtect VPN, based on OpenConnect, supports the SSO authentication method.
AddPackage bluetui # TUI for managing bluetooth devices
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack

CreateDir /etc/iwd # for Wi-Fi capabilities
