#!/bin/bash
cd ~
pacman -S --needed - <importantpackage.txt
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
yay -S --needed - <importantpackageaur.txt

echo "Then remember to activate the necessary services"
echo "At least, iwgtk.service, systemd-resolved.service for wifi (iwgtk needs extra tweaking in order to do the dns resolving)"
echo "https://wiki.archlinux.org/title/Iwd"
echo "maybe it will be needed to download treesitter also from cargo and then add ~/.cargo/bin to the path"
echo "Also don't forget to download a nerd font (mononoki is good)"
