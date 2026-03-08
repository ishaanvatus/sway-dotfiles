#!/bin/sh

mkdir -p ~/documents ~/downloads ~/music ~/pictures ~/videos ~/.config/xfce4 ~/.software ~/src ~/.local/bin 
sudo dnf -y install stow
rm ~/.bashrc ~/.bash_profile ~/.profile
stow .
./rpmfusion.sh
./packages.sh
./flatpaks.sh
./services.sh
