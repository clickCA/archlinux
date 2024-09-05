# After finishing the installation

This is a guide to follow the [General Recommendations](https://wiki.archlinux.org/title/General_recommendations) for Arch Linux installation.

- [Dual boot setup](./dual-boot.md): This will help Grub detect the Windows boot.

- Fix font rendering issue in KDE Plasma.

- Remove kmix from KDE Plasma to fix the annoying icon tray.

- Install oh my bash theme:

    ```bash
    pacman -S oh-my-bash
    # OSH_THEME='tylenol'
    ```

- Improve download speed in the terminal.

- Be cautious when updating the system with Nvidia drivers.

- Install fastfetch to show off.

- Install touchpad gestures using [touchegg](../os/touchpad.sh).

- Create a backup using Timeshift after finishing the configuration.

- When `pacman -Syu` it recommends to install outside the desktop environment because it can cause upgrade that break the dependencies.