# Arch linux

Boot with ventoy and install via this command:

```jsx
archinstall
```

[YouTube video: Booting and Installing Arch Linux with Ventoy](https://youtu.be/r5CXwtwdUmc?si=vaIT68GUpui-50ql)

To make Windows dual boot, follow the steps in this video: [Dual Boot Arch Linux with Windows](https://youtu.be/xBPn0fF8bTY?si=V4sB-JPpXsx0e90c)

```jsx
sudo pacman -S os-prober ntfs-3g neovim
sudo nvim /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Oh My Bash theme:

```jsx
OSH_THEME='tylenol'
```


## Development Applications

**MySQL**

- [Arch Linux Wiki: MariaDB](https://wiki.archlinux.org/title/MariaDB)

- [Arch Linux Wiki: MySQL](https://wiki.archlinux.org/title/MySQL)

## Troubleshooting

```bash
pacman -Syu
# Be careful, dont ever use this command may have issues when updating Nvidia drivers
```

Stop job is running for user manager for UID 1000" error during shutdown:

- [Super User: Activation via systemd failed for unit dbus-org.freedesktop.resolve1.service](https://superuser.com/questions/1427311/activation-via-systemd-failed-for-unit-dbus-org-freedesktop-resolve1-service)

Improving download speed in the terminal:

- [Arch Linux Wiki: Reflector](https://wiki.archlinux.org/title/reflector)

- [Arch Linux Man Page: reflector](https://man.archlinux.org/man/reflector.1#EXAMPLES)

Fixing inconsistent font rendering:

- [Super User: Notification box in KDE Plasma does not display all emoji as colored](https://superuser.com/questions/1800068/notification-box-in-kde-plasma-does-not-display-all-emoji-as-coloured)

Slow download speed:

- [DebugPoint: Slow Download Speed in Pacman on Arch Linux](https://www.debugpoint.com/slow-download-pacman-arch/)

Install conda in archlinux:
