#!/bin/bash

# Update package lists
sudo pacman -Syu

# Install git (required for NVM)
sudo pacman -S git

# Clone the NVM repository
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash


# Verify installation
node -v
npm -v

npm install -g yarn

echo "Node.js LTS version $(node -v) and npm are installed!"
