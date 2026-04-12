#!/bin/sh

PKGS="7zip blueman cage calibre chafa chromium cowsay cups ddcutil fonts-noto fonts-noto-cjk easytag libexpat1-dev faketime fastfetch ffmpeg libffmpegthumbnailer4 file-roller foliate fortune-mod freerdp2-x11 fuzzel gammastep gimp gnome-themes-extra golang fonts-noto-color-emoji gparted grim libgstreamer1.0-dev gstreamer1.0-plugins-bad libgstreamer-plugins-base1.0-dev libgutenprint-dev gvfs gvfs-backends handbrake handbrake-cli hplip htop imagemagick libimlib2-dev libexif-dev libjxl-tools libreoffice libxft-dev light lxappearance lxpolkit liblz4-dev gnome-disk-utility meson mkvtoolnix mkvtoolnix-gui moreutils mpv nasm ncdu network-manager-gnome network-manager libnm-dev ninja-build nmap opus-tools pamixer pandoc pavucontrol perl libfile-mimeinfo-perl playerctl potrace python3-setuptools python3-tk qbittorrent qt5-qmake qtbase5-dev qt5ct qt6ct sqlitebrowser stow strawberry sway swaylock fonts-terminus thunar thunar-archive-plugin thunar-volman tlp tree-sitter ufw vlc waybar libwayland-dev wayland-protocols wdisplays xdg-user-dirs xsane zathura zathura-cb zathura-pdf-poppler"

mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures/screenshots/mpv ~/public ~/templates ~/videos ~/src
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4
mkdir ~/.trash
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

sudo apt-get -y update && sudo apt-get -y upgrade

# Laptop stays on when closing lid
sudo mkdir /etc/systemd/logind.conf.d/
echo "[Login]" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitch=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchDocked=ignore" | sudo tee -a /etc/systemd/logind.conf.d/99-laptop-server.conf

# /etc/vconsole.conf
echo "KEYMAP="us"" | sudo tee /etc/vconsole.conf
echo "FONT="ter-132b"" | sudo tee -a /etc/vconsole.conf

# udev rules for vial for my Unicomp Mini-M
echo "# Unicomp Mini M" | sudo tee -a /etc/udev/rules.d/99-unicomp-mini-m.rules
echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", ATTRS{idVendor}==\"16c0\", ATTRS{idProduct}==\"27db\", MODE=\"0660\", GROUP=\"sudo\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" | sudo tee -a /etc/udev/rules.d/99-unicomp-mini-m.rules

sudo apt-get -y install stow
rm ~/.bashrc ~/.bash_profile
stow .
source ~/.bashrc

# packages
sudo apt-get -y install ${PKGS}

## browser

## librewolf
curl -fsSL https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/librewolf.gpg] https://deb.librewolf.net $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/librewolf.list
sudo apt-get update
sudo apt-get -y install librewolf
## mullvad
curl -fsSL https://repository.mullvad.net/deb/mullvad-keyring.asc | sudo gpg --dearmor -o /usr/share/keyrings/mullvad-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.gpg] https://repository.mullvad.net/deb/stable $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
sudo apt-get update
sudo apt-get -y install mullvad-browser


sudo apt-get -y install qemu-kvm libvirt-daemon-system libvirt-clients virt-manager
sudo usermod -a -G libvirt $(whoami)

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -sc) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $(whoami)


sudo apt-get -y remove yt-dlp
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
sudo apt-get -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#flatpak -y install flathub \
#    com.obsproject.Studio \
#    org.gnome.Epiphany \
#    org.signal.Signal \
#    org.kde.kdenlive \
#    org.mozilla.Thunderbird \
#    io.github.ciromattia.kcc \
#    org.jdownloader.JDownloader
## services
xdg-user-dirs-update

systemctl --user enable kanshi.service
systemctl --user start sway-session.target
sudo systemctl enable tlp
echo "START_CHARGE_THRESH_BAT0=40" | sudo tee -a /etc/tlp.conf
echo "STOP_CHARGE_THRESH_BAT0=60" | sudo tee -a /etc/tlp.conf
sudo systemctl enable docker
sudo systemctl enable sddm

sudo systemctl set-default graphical.target
sudo update-grub
sudo plymouth-set-default-theme hot-dog
sudo update-initramfs -u

sleep 10s

echo "rebooting in 5 seconds press <C-c> to stop"
sleep 10s

sudo systemctl reboot
