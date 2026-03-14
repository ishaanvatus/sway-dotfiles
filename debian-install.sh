#!/bin/sh

PKGS="7z blueman cage calibre chafa chromium cowsay cups ddcutil default-fonts-cjk expat-devel fastfetch ffmpeg-devel ffmpegthumbnailer file-roller foliate fortune-mod freerdp fuzzel gammastep gimp gimp-resynthesizer gnome-themes-extra golang gparted grim grimpicker gstreamer1-plugins-bad-free-extras gutenprint gutenprint-devel gvfs-mtp gvfs-smb HandBrake HandBrake-gui hplip htop ImageMagick imlib2-devel iwlwifi-mvm-firmware kanshi keepassxc libexif-devel  libjxl-utils libreoffice libXft-devel light lxappearance lxpolkit lz4-devel mediawriter mkvtoolnix mkvtoolnix-gui moreutils mpv mpv-mpris ncdu neovim network-manager-applet NetworkManager-tui NetworkManager-wifi nmap pamixer pandoc pavucontrol perl-core playerctl potrace protontricks python3-setuptools qbittorrent qt5ct qt5-qtbase-devel qt6ct rpi-imager slurp steam stow strawberry sway swaylock terminus-fonts-console thunar thunar-archive-plugin tlp torbrowser-launcher ufw vlc waybar wayland-devel wayland-protocols-devel wdisplays xdg-user-dirs xsane zathura zathura-pdf-mupdf"

mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures/screenshots/mpv ~/public ~/templates ~/videos
mkdir -p ~/games ~/src
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4 
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

sudo apt -y update
sudo apt -y upgrade

sudo mkdir /etc/systemd/logind.conf.d/
sudo touch /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "[Login]" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitch=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchDocked=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf

sudo apt -y install stow
rm ~/.bashrc ~/.bash_profile
stow .
source ~/.bashrc


sudo apt -y purge yt-dlp
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
chmod a+rx ~/.local/bin/yt-dlp  # Make executable

go install go.senan.xyz/cliphist@latest
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

echo "don't add anything to path for rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "don't add anything to path or enable completions for deno"
curl -fsSL https://deno.land/install.sh | sh
source ~/.bashrc
deno completions bash > ~/.bashrc.d/user/deno.bash

## flatpaks
sudo apt -y install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak -y install flathub com.obsproject.Studio
flatpak -y install flathub org.gnome.Epiphany
flatpak -y install flathub org.signal.Signal
flatpak -y install flathub org.kde.kdenlive
flatpak -y install flathub org.mozilla.Thunderbird

## services
sudo systemctl enable tlp
sudo systemctl enable docker
systemctl --user enable kanshi.service
systemctl --user start sway-session.target
echo "You should probably reboot before using this system :|"
