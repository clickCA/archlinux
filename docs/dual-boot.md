## Check that the os-prober package is installed
```
pacman -S os-prober
```
## Change the GRUB configuration file
```
vim /etc/default/grub
```
## Add the following line
```
GRUB_DISABLE_OS_PROBER=false
```
## Update the GRUB configuration
```
os-prober
grub-mkconfig -o /boot/grub/grub.cfg
```
