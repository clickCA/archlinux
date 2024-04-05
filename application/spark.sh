cd ~/Downloads
git clone https://aur.archlinux.org/apache-spark.git
cd apache-spark
makepkg -si
cd ..
rm -rf apache-spark
# End of snippet