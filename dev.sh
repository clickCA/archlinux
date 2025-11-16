#!/bin/bash
#
# post-install-gnome-dev.sh
#
# A single script to set up a fresh Arch Linux system with GNOME for Node.js, Docker, and Go development.
#
# USAGE:
#   1. Save this script to a file (e.g., post-install-gnome-dev.sh).
#   2. Make it executable: chmod +x post-install-gnome-dev.sh
#   3. Run it with sudo: ./post-install-gnome-dev.sh
#

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Pre-flight Checks ---
# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root. Please use sudo." >&2
   exit 1
fi

# Get the original user who called sudo
SUDO_USER=$SUDO_USER
if [ -z "$SUDO_USER" ]; then
    echo "Please run this script with sudo (e.g., ./post-install-gnome-dev.sh)" >&2
    exit 1
fi

# --- Main Installation ---

echo "========================================="
echo "  Arch Linux Post-Install for Devs"
echo "  (GNOME, Node.js via fnm, Docker, Go)"
echo "========================================="
echo

# 1. Update System
echo ">>> [1/7] Updating full system..."
pacman -Syu --noconfirm --needed
echo "System updated."
echo

# 2. Install Essential & GNOME Tools
echo ">>> [2/7] Installing essential and GNOME packages..."
pacman -S --noconfirm --needed \
    git \
    curl \
    wget \
    base-devel \
    neovim \
    htop \
    fzf \
    gnome-tweaks \
    libsecret
echo "Essential and GNOME tools installed."
echo

# 3. Install Go
echo ">>> [3/7] Installing Go..."
pacman -S --noconfirm --needed go
echo "Go installed."
echo

# 4. Install Docker
echo ">>> [4/7] Installing Docker and Docker Compose..."
pacman -S --noconfirm --needed docker docker-compose

# Enable and start the Docker service
systemctl enable docker
systemctl start docker

# Add the user to the docker group
usermod -aG docker "$SUDO_USER"
echo "Docker installed and started."
echo "User '$SUDO_USER' added to the 'docker' group."
echo

# 5. Install fnm (Fast Node Manager)
echo ">>> [5/7] Installing fnm..."
pacman -S --noconfirm --needed fnm
echo "fnm installed."
echo

# 6. Configure User-Specific Settings
echo ">>> [6/7] Configuring user environment..."

# Run as the target user
sudo -u "$SUDO_USER" bash -c '
    echo "Configuring Git to use libsecret for credential storage..."
    git config --global credential.helper /usr/libexec/git-core/git-credential-libsecret

    echo "Installing latest Node.js LTS version using fnm..."
    # The fnm binary is in the standard PATH, so we can call it directly.
    fnm install --lts
    fnm use --lts
    fnm alias default lts-latest
'
echo "User environment configured."
echo

# 7. Final Cleanup and Message
echo ">>> [7/7] Installation complete!"
echo "========================================="
echo "  POST-INSTALLATION STEPS:"
echo "========================================="
echo
echo "1. RESTART YOUR SHELL:"
echo "   - Log out and log back in to apply the 'docker' group membership."
echo "   - Start a new terminal session to use 'fnm' and 'node' commands."
echo
echo "2. INITIALIZE fnm IN YOUR SHELL:"
echo "   - Add the following line to your ~/.bashrc (or ~/.zshrc if you use Zsh):"
echo "     eval \"\$(fnm env)\""
echo "   - Then run: source ~/.bashrc"
echo
echo "3. CONFIGURE GIT:"
echo "   git config --global user.name \"Your Name\""
echo "   git config --global user.email \"you@example.com\""
echo
echo "4. (Optional) ADD GO TOOLS TO PATH:"
echo "   Add this to your ~/.bashrc or ~/.zshrc for Go tools:"
echo "   export PATH=\$PATH:$(go env GOPATH)/bin"
echo
echo "5. GNOME TWEAKS:"
echo "   'gnome-tweaks' was installed. You can find it in your applications menu to customize your desktop."
echo
echo "Happy developing!"
