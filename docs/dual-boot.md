# Make the system dual-boot

from [ArchWiki](https://wiki.archlinux.org/title/GRUB#Detecting_other_operating_systems)

## Detecting other operating systems

To have `grub-mkconfig` search for other installed systems and automatically add them to the menu, follow these steps:

1. Install the `os-prober` package:

    ```bash
    pacman -S os-prober
    ```

2. Mount the partitions from which the other systems boot.

3. Edit the `/etc/default/grub` file and add/uncomment the following line:

    ```bash
    GRUB_DISABLE_OS_PROBER=false
    ```

4. Update the GRUB configuration:

    ```bash
    os-prober
    grub-mkconfig -o /boot/grub/grub.cfg
    ```

**Note:**

- The exact mount point does not matter, as `os-prober` reads the `mtab` to identify places to search for bootable entries.
- Remember to mount the partitions each time you run `grub-mkconfig` in order to include the other operating systems every time.
- `os-prober` might not work properly when run in a chroot. If you experience this, try again after rebooting into the system.
- You might also want GRUB to remember the last chosen boot entry. See `/Tips and tricks#Recall previous entry` for more information.
