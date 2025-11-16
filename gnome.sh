#!/bin/bash
#
# post-install-arch-fonts-focused.sh
#
# A comprehensive script to set up a fresh Arch Linux with GNOME for development and general use.
# This version focuses on achieving macOS-quality font rendering.
#
# FEATURES:
# - Installs dev tools (Node.js via fnm, Docker, Go, Miniconda)
# - Optimizes system (fastest pacman mirrors via reflector)
# - **Installs and configures fonts for a macOS-like appearance.**
# - Sets up essential OS services (Audio, Bluetooth, Power, Printing, Touchegg)
# - Prepares system for Windows dual-boot
#
# USAGE:
#   1. Save this script to a file (e.g., post-install-arch-fonts-focused.sh).
#   2. Make it executable: chmod +x post-install-arch-fonts-focused.sh
#   3. Run it with sudo: ./post-install-arch-fonts-focused.sh
#

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Pre-flight Checks ---
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root. Please use sudo." >&2
   exit 1
fi

SUDO_USER=$SUDO_USER
if [ -z "$SUDO_USER" ]; then
    echo "Please run this script with sudo." >&2
    exit 1
fi

# --- Main Installation ---

echo "========================================="
echo "  Arch GNOME Post-Install (Font-Focused)"
echo "========================================="
echo

# 1. Update System
echo ">>> [1/13] Updating full system..."
echo "!!! WARNING: Always check https://archlinux.org/news/ before a major system update. !!!"
pacman -Syu --noconfirm --needed
echo "System updated."
echo

# 2. Install Essentials & AUR Helper (yay)
echo ">>> [2/13] Installing base packages and AUR helper (yay)..."
pacman -S --noconfirm --needed \
    git \
    curl \
    wget \
    base-devel \
    neovim \
    htop \
    fzf

if ! command -v yay &> /dev/null; then
    echo "Yay not found. Installing..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    chown -R "$SUDO_USER":"$SUDO_USER" ./yay
    cd yay
    sudo -u "$SUDO_USER" makepkg -si --noconfirm
    cd ..
    rm -rf yay
    echo "Yay installed."
else
    echo "Yay is already installed."
fi
echo

# 3. Optimize Pacman Mirrors with Reflector
echo ">>> [3/13] Optimizing pacman download mirrors with reflector..."
pacman -S --noconfirm --needed reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --country 'United States,Canada' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --latest 100 --number 50
echo "Mirrorlist updated with the fastest mirrors."
echo

# 4. Install OS-Level Packages for a Functional Desktop
echo ">>> [4/13] Installing OS-level packages (Audio, Bluetooth, Power, etc.)..."
pacman -S --noconfirm --needed \
    pipewire \
    pipewire-pulse \
    wireplumber \
    bluez \
    bluez-utils \
    tlp \
    cups \
    touchegg \
    gnome-tweaks \
    libsecret
echo "OS-level packages installed."
echo

# 5. Install macOS-like Font Set
echo ">>> [5/13] Installing a high-quality font set to mimic macOS..."
# Official repo fonts
# - noto-fonts: A versatile UI font, a great default.
# - noto-fonts-cjk: The best open-source equivalent to macOS's PingFang/Hiragino fonts for CJK characters.
# - noto-fonts-emoji: For modern, color emoji support.
pacman -S --noconfirm --needed \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji

# AUR fonts
# - nerd-fonts-sf-mono: Provides the SF Mono font (Apple's monospaced font) with extra glyphs.
# - ttf-google-thai: The best open-source equivalent to macOS's Sukhumvit Set Thai font.
echo "Installing SF Mono and Google Thai fonts from AUR..."
sudo -u "$SUDO_USER" yay -S --noconfirm --needed \
    nerd-fonts-sf-mono \
    ttf-google-thai
echo "Font set installed."
echo

# 6. Apply macOS-like Font Rendering Configuration
echo ">>> [6/13] Applying font rendering configuration to match macOS quality..."
sudo -u "$SUDO_USER" mkdir -p "/home/$SUDO_USER/.config/fontconfig"
sudo -u "$SUDO_USER" tee "/home/$SUDO_USER/.config/fontconfig/fonts.conf" > /dev/null <<'EOF'
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>

    <!-- Preferred Font Aliases: Set high-quality defaults -->
    <alias>
        <family>serif</family>
        <prefer><family>Noto Serif</family></prefer>
    </alias>
    <alias>
        <family>sans-serif</family>
        <prefer><family>Noto Sans</family></prefer>
        <prefer><family>Noto Sans CJK SC</family></prefer>
    </alias>
    <alias>
        <family>monospace</family>
        <prefer><family>SF Mono</family></prefer>
        <prefer><family>Noto Sans Mono CJK SC</family></prefer>
    </alias>

    <!-- Generic Rendering Settings: The foundation for smooth text -->
    <match target="font">
        <edit mode="assign" name="antialias"><bool>true</bool></edit>
    </match>
    <match target="font">
        <edit mode="assign" name="hinting"><bool>true</bool></edit>
    </match>

    <!-- The Key to macOS-like Rendering: Use Slight Hinting -->
    <!-- This preserves the original design of the font, especially for CJK and Thai characters. -->
    <match target="font">
        <edit mode="assign" name="hintstyle"><const>hintslight</const></edit>
    </match>

    <!-- Enable Subpixel Rendering for crisp text on LCD screens -->
    <match target="font">
        <edit mode="assign" name="rgba"><const>rgb</const></edit>
    </match>

</fontconfig>
EOF
echo "Font rendering configuration applied."
echo "NOTE: You will need to log out and log back in for all changes to take effect."
echo

# 7. Install Development Tools
echo ">>> [7/13] Installing development tools (Go, Docker, fnm)..."
pacman -S --noconfirm --needed go docker fnm
echo "Dev tools installed."
echo

# 8. Install Miniconda
echo ">>> [8/13] Installing Miniconda..."
cd /tmp
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
sudo -u "$SUDO_USER" wget -O miniconda.sh "$MINICONDA_URL"
sudo -u "$SUDO_USER" bash miniconda.sh -b -p "/home/$SUDO_USER/miniconda3"
rm miniconda.sh
echo "Miniconda installed."
echo

# 9. Configure Dual-Boot (Windows)
echo ">>> [9/13] Preparing system for dual-boot with Windows..."
pacman -S --noconfirm --needed os-prober ntfs-3g
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
echo "Dual-boot packages installed and GRUB configured."
echo "NOTE: You will need to run 'sudo grub-mkconfig -o /boot/grub/grub.cfg' after rebooting to detect Windows."
echo

# 10. Enable and Start System Services
echo ">>> [10/13] Enabling and starting system services..."
systemctl enable docker && systemctl start docker
systemctl enable bluetooth.service && systemctl start bluetooth.service
systemctl enable tlp.service && systemctl enable NetworkManager-dispatcher.service && tlp start
systemctl enable cups.service && systemctl start cups.service
echo "Services enabled and started."
echo

# 11. Configure User Environment
echo ">>> [11/13] Configuring user environment..."
usermod -aG docker "$SUDO_USER"
sudo -u "$SUDO_USER" bash -c '
    git config --global credential.helper /usr/libexec/git-core/git-credential-libsecret
    fnm install --lts
    fnm use --lts
    fnm alias default lts-latest
    /home/'$SUDO_USER'/miniconda3/bin/conda init bash
    /home/'$SUDO_USER'/miniconda3/bin/conda init zsh
'
echo "User environment configured."
echo

# 12. Video Driver Instructions (CRITICAL)
echo ">>> [12/13] VIDEO DRIVER SETUP"
echo "This script cannot automatically install your video drivers."
echo "Please install them manually based on your hardware:"
echo "  1. First, identify your GPU: lspci -k | grep -A 2 -i vga"
echo "  2. Then, install the appropriate driver:"
echo "     - For Intel:  sudo pacman -S intel-media-driver vulkan-intel"
echo "     - For AMD:    sudo pacman -S mesa libva-mesa-driver vulkan-radeon"
echo "     - For NVIDIA: sudo pacman -S nvidia nvidia-settings nvidia-utils"
echo

# 13. Final Cleanup and Message
echo ">>> [13/13] Installation complete!"
echo "========================================="
echo "  POST-INSTALLATION STEPS:"
echo "========================================="
echo
echo "1. REBOOT YOUR SYSTEM:"
echo "   This is highly recommended to ensure all changes take full effect."
echo
echo "2. INITIALIZE YOUR SHELL:"
echo "   - Add this to your ~/.bashrc or ~/.zshrc: eval \"\$(fnm env)\""
echo "   - Restart your terminal. Conda and fnm will now be available."
echo
echo "3. CONFIGURE GIT:"
echo "   git config --global user.name \"Your Name\""
echo "   git config --global user.email \"you@example.com\""
echo
echo "4. (IF DUAL-BOOTING) DETECT WINDOWS:"
echo "   After rebooting, run this command to add Windows to your GRUB menu:"
echo "   sudo os-prober && sudo grub-mkconfig -o /boot/grub/grub.cfg"
echo
echo "5. ENJOY THE FONTS:"
echo "   Your system should now have crisp, clean, and beautiful font rendering"
echo "   for English, Chinese, Thai, and other languages, similar to macOS."
echo
echo "Happy developing!"
