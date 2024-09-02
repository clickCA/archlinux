#!/bin/bash

# Update package lists
sudo pacman -Syu

# Install git (required for NVM)
sudo pacman -S git

# Clone the NVM repository
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install --lts
# Verify installation
node -v
npm -v
# Install unzip
sudo pacman -S unzip
# Install bun
curl -fsSL https://bun.sh/install | bash

# Install yarn
npm install -g yarn

echo "Node.js LTS version $(node -v) and npm are installed!"
