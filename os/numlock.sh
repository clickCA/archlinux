cd ~/Downloads
git clone https://aur.archlinux.org/mkinitcpio-numlock.git
cd mkinitcpio-numlock
makepkg -si
cd ..
rm -rf mkinitcpio-numlock
# End of snippet