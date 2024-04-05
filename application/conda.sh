git clone https://aur.archlinux.org/miniconda3.git
cd miniconda3
makepkg -si
cd ..
rm -rf miniconda3
conda create --name myenv