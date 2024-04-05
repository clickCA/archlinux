sudo pacman -Sy git
cd Downloads
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si
cd ..
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd ..
pacman -Sy discord 
git clone https://aur.archlinux.org/telegram-desktop-bin.git
cd telegram-desktop-bin
makepkg -si
cd ..
git clone https://aur.archlinux.org/notion-app.git 
cd notion-app
makepkg -si
cd ..
git clone https://aur.archlinux.org/smartgit.git
cd smartgit
makepkg -si
cd ..
git clone https://aur.archlinux.org/insomnia.git
cd insomnia
makepkg -si
cd ..
