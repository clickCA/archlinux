# Arch Linux Installation Guide

[Watch the video tutorial](https://www.youtube.com/watch?v=FxeriGuJKTM&t=2794s)

## Connecting to WiFi

To connect to WiFi from within the Arch installer using the command line method, follow these steps:

1. Find your WiFi device name:
    - Run `ip addr show` command to see your wireless device name in the output.

2. Scan for available WiFi Networks:
    - Run `iwctl` command to enter a different shell.
    - Run `station wlan0 get-networks` command to scan for networks.
    - Make note of the network you want to connect to.
    - Exit the `iwctl` shell.

3. Connect to the desired network:
    - Run the following command, replacing `<passphrase>` with your network passphrase and `<interface>` with your WiFi device name:

      ```bash
      iwctl --passphrase <passphrase> station <interface> connect NetworkName
      ```

## Manual Installation Notes

Here are some commands used during the video for manual installation:

- Display current partition info: `lsblk`
- Beginning the partitioning process: `fdisk nvme0n1` (replace `nvme0n1` with the appropriate device name)
- Print current partition layout: `p` (within the `fdisk` shell)
- Create Partitions:
  - `g` (to create an empty GPT partition table)
  - `n`, `1`, `enter`, `+1G` (for the first partition)
  - Repeat the above step for the second and third partitions
- Format the EFI partition: `mkfs.fat -F32 /dev/nvme0n1p1`
- Format the Boot partition: `mkfs.ext4 /dev/nvme0n1p2`
- Set up encryption:
  - Encrypt the third partition: `cryptsetup luksFormat /dev/nvme0n1p3`
  - Unlock the encrypted volume: `cryptsetup open --type luks /dev/nvme0n1p3 lvm`
- Set up LVM:
  - Create a physical volume: `pvcreate /dev/mapper/lvm`
  - Create a volume group: `vgcreate volgroup0 /dev/mapper/lvm`
  - Create logical volumes: `lvcreate -L 30GB volgroup0 -n lv_root` and `lvcreate -L 250GB volgroup0 -n lv_home`
  - Activate the volume group: `modprobe dm_mod`, `vgscan`, `vgchange -ay`
- Format and mount the partitions:
  - Format logical volumes: `mkfs.ext4 /dev/volgroup0/lv_root` and `mkfs.ext4 /dev/volgroup0/lv_home`
  - Mount partitions: `mount /dev/volgroup0/lv_root /mnt`, `mkdir /mnt/boot`, `mount /dev/nvme0n1p2 /mnt/boot`, `mkdir /mnt/home`, `mount /dev/volgroup0/lv_home /mnt/home`

## Preparing the Arch installation environment

- Install base packages: `pacstrap -i /mnt base`
- Generate fstab file: `genfstab -U -p /mnt >> /mnt/etc/fstab`
- Access the installation: `arch-chroot /mnt`

## User accounts

- Set password for root account: `passwd`
- Create a user account: `useradd -m -g users -G wheel jay`
- Set password for the user account: `passwd jay`

## Install basic packages

- Install required packages: `pacman -S base-devel dosfstools grub efibootmgr gnome gnome-tweaks lvm2 mtools nano networkmanager openssh os-prober sudo`
- Install SSH (optional): `pacman -S openssh` and enable it: `systemctl enable sshd`
- Install kernel: `pacman -S linux linux-headers linux-lts linux-lts-headers`
- Install firmware files: `pacman -S linux-firmware`
- Inspect GPU: `lspci`
- Install GPU drivers:
  - Intel or AMD GPU: `pacman -S mesa`
  - Nvidia GPU: `pacman -S nvidia nvidia-utils`
  - Nvidia GPU with LTS kernel: `pacman -S nvidia-lts`
- Install accelerated video decoding support (if needed):
  - Intel (Broadwell and newer): `pacman -S intel-media-driver`
  - Intel GMA 4500 up to Coffee Lake: `pacman -S libva-mesa-driver`
  - AMD: `pacman -S libva-mesa-driver`
- Install the timeshift package: `pacman -S timeshift` and enable the service: `systemctl enable cronie.service`
`

## Edit configuration files

- Edit `/etc/mkinitcpio.conf`: `nano /etc/mkinitcpio.conf` and add `encrypt lvm2` between `block` and `filesystems`
- Generate kernel ramdisks:
  - For `linux` package: `mkinitcpio -p linux`
  - For `linux-lts` package: `mkinitcpio -p linux-lts`
- Edit `/etc/locale.gen` and uncomment `en_US.UTF-8`: `nano /etc/locale.gen` and run `locale-gen`
- Set up GRUB:
  - Edit `/etc/default/grub`: `vim /etc/default/grub`
  - Add `cryptdevice=/dev/<device-name>:<volume-group>` to `GRUB_CMDLINE_LINUX_DEFAULT`
  - Create `/boot/EFI` directory and mount the first partition: `mkdir /boot/EFI` and `mount /dev/nvme0n1p1 /boot/EFI`
  - Install GRUB: `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck`
  - Copy locale files for GRUB: `cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  - Generate GRUB config file: `grub-mkconfig -o /boot/grub/grub.cfg`
- Enable GDM: `systemctl enable gdm`
- Enable NetworkManager: `systemctl enable NetworkManager`

## Wrapping Up

- Exit the chroot environment: `exit`
- Unmount all partitions: `umount -a`
- Reboot the system: `reboot`
