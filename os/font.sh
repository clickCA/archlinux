pacman -Sy 	noto-fonts-cjk
git clone https://aur.archlinux.org/ttf-google-thai.git
cd ttf-google-thai
makepkg -si
cd ..
git clone https://aur.archlinux.org/nerd-fonts-sf-mono.git
cd nerd-fonts-sf-mono
makepkg -si
cd ..
