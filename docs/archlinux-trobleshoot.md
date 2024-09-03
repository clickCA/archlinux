# Arch linux

Boot with ventoy and install via this command:

```bash
archinstall
```

Guide from official link:
- [Installation Guide](https://wiki.archlinux.org/title/Installation_guide)

Install multiple Linux kernels:
- Linux
- linux-zen

To fix the problem when having kernel doom, the bootloader will show which kernel you want to boot.

[YouTube video: Booting and Installing Arch Linux with Ventoy](https://youtu.be/r5CXwtwdUmc?si=vaIT68GUpui-50ql)



## Troubleshooting

```bash
pacman -Syu
# Be careful, don't ever use this command as it may have issues when updating Nvidia drivers
```

"Stop job is running for user manager for UID 1000" error during shutdown:

- [Super User: Activation via systemd failed for unit dbus-org.freedesktop.resolve1.service](https://superuser.com/questions/1427311/activation-via-systemd-failed-for-unit-dbus-org-freedesktop-resolve1-service)

Improving download speed in the terminal:

- [Arch Linux Wiki: Reflector](https://wiki.archlinux.org/title/reflector)
- [Arch Linux Man Page: reflector](https://man.archlinux.org/man/reflector.1#EXAMPLES)

Fixing inconsistent font rendering:

- [Super User: Notification box in KDE Plasma does not display all emoji as colored](https://superuser.com/questions/1800068/notification-box-in-kde-plasma-does-not-display-all-emoji-as-coloured)

Slow download speed:

- [DebugPoint: Slow Download Speed in Pacman on Arch Linux](https://www.debugpoint.com/slow-download-pacman-arch/)

Install conda in Arch Linux:

