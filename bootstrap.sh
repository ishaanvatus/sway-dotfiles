#!/bin/sh

mkdir -p ~/documents ~/downloads ~/music ~/pictures ~/videos ~/.config/xfce4 ~/.software ~/src ~/.local/bin ~/.local/share/fonts/Mononoki
cp Mononoki/* ~/.local/share/fonts/Mononoki/

echo "max_parallel_downloads=6" | sudo tee -a  /etc/dnf/dnf.conf
sudo dnf -y upgrade --refresh

sudo dnf -y install stow
rm ~/.bashrc ~/.bash_profile
stow .

source ~/.bashrc
bash rpmfusion.sh
bash packages.sh
bash flatpaks.sh
bash services.sh
