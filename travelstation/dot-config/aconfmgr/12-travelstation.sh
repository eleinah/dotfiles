AddPackage intel-media-driver                      # for hardware accelerated decoding
AddPackage --foreign evsieve                       # lenovo pen support
AddPackage iio-sensor-proxy                        # screen rotation detection and tablet mode
AddPackage power-profiles-daemon                   # laptop power saving modes
AddPackage dhcpcd                                  # for DHCP resolution
AddPackage iwd                                     # for Wi-Fi capabilities
AddPackage --foreign globalprotect-openconnect-git # A GUI for GlobalProtect VPN, based on OpenConnect, supports the SSO authentication method.
AddPackage --foreign vmware-vmrc                   # Remote Console for VMware (used for work, vSphere)

CreateDir /etc/iwd # for Wi-Fi capabilities
