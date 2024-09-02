sudo pacman -Sy git
cd Downloads
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si
cd ..
sudo rm -rf google-chrome

# development
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd ..
sudo rm -rf visual-studio-code-bin
curl -f https://zed.dev/install.sh | sh
# social media
pacman -Sy discord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)" # Vencord
git clone https://aur.archlinux.org/telegram-desktop-bin.git
cd telegram-desktop-bin
makepkg -si
cd ..
sudo rm -rf telegram-desktop-bin

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
