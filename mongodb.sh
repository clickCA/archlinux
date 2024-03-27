cd ~/Downloads
git clone https://aur.archlinux.org/mongodb-compass.git
cd mongodb-compass
makepkg -si
cd ..
rm -rf mongodb-compass