#!/bin/sh

mkdir -p ~/documents ~/downloads ~/music ~/pictures ~/videos ~/.config/xfce4 ~/.software ~/src ~/.local/bin ~/.local/share/fonts/Mononoki
cp Mononoki/* ~/.local/share/fonts/Mononoki/
sudo dnf -y install stow
rm ~/.bashrc ~/.bash_profile
stow .
source ~/.bashrc
bash rpmfusion.sh
bash packages.sh
bash flatpaks.sh
bash services.sh
