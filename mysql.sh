sudo pacman -S mariadb
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql