#!/bin/sh

PKGS="7z blueman cage calibre chafa chromium cowsay cups ddcutil default-fonts-cjk expat-devel fastfetch ffmpeg-devel ffmpegthumbnailer file-roller foliate fortune-mod freerdp fuzzel gammastep gimp gimp-resynthesizer gnome-themes-extra golang gparted grim grimpicker gstreamer1-plugins-bad-free-extras gutenprint gutenprint-devel gvfs-mtp gvfs-smb HandBrake HandBrake-gui hplip htop ImageMagick imlib2-devel iwlwifi-mvm-firmware kanshi keepassxc libexif-devel  libjxl-utils libreoffice libXft-devel light lxappearance lxpolkit lz4-devel mediawriter mkvtoolnix mkvtoolnix-gui moreutils mpv mpv-mpris ncdu neovim network-manager-applet NetworkManager-tui NetworkManager-wifi nmap pamixer pandoc pavucontrol perl-core playerctl potrace protontricks python3-setuptools qbittorrent qt5ct qt5-qtbase-devel qt6ct rpi-imager slurp steam stow strawberry sway swaylock terminus-fonts-console thunar thunar-archive-plugin tlp torbrowser-launcher ufw vlc waybar wayland-devel wayland-protocols-devel wdisplays xdg-user-dirs xsane zathura zathura-pdf-mupdf"

mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures/screenshots/mpv ~/public ~/templates ~/videos
mkdir -p ~/games ~/src
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4 
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install stow
stow .
sudo apt install 7z
sudo apt install blueman
sudo apt install cage
sudo apt install calibre
sudo apt install chafa
sudo apt install chromium
sudo apt install cowsay
sudo apt install cups
sudo apt install ddcutil
sudo apt install default-fonts-cjk
sudo apt install expat-devel
sudo apt install fastfetch
sudo apt install ffmpeg-devel
sudo apt install ffmpegthumbnailer
sudo apt install file-roller
sudo apt install foliate
sudo apt install fortune-mod
sudo apt install freerdp
sudo apt install fuzzel
sudo apt install gammastep
sudo apt install gimp
sudo apt install gimp-resynthesizer
sudo apt install gnome-themes-extra
sudo apt install golang
sudo apt install gparted
sudo apt install grim
sudo apt install grimpicker
sudo apt install gstreamer1-plugins-bad-free-extras
sudo apt install gutenprint
sudo apt install gutenprint-devel
sudo apt install gvfs-mtp
sudo apt install gvfs-smb
sudo apt install HandBrake
sudo apt install HandBrake-gui
sudo apt install hplip
sudo apt install htop
sudo apt install ImageMagick
sudo apt install imlib2-devel
sudo apt install iwlwifi-mvm-firmware
sudo apt install kanshi
sudo apt install keepassxc
sudo apt install libexif-devel
sudo apt install libjxl-utils
sudo apt install libreoffice
sudo apt install libXft-devel
sudo apt install light
sudo apt install lxappearance
sudo apt install lxpolkit
sudo apt install lz4-devel
sudo apt install mediawriter
sudo apt install mkvtoolnix
sudo apt install mkvtoolnix-gui
sudo apt install moreutils
sudo apt install mpv
sudo apt install mpv-mpris
sudo apt install ncdu
sudo apt install neovim
sudo apt install network-manager-applet
sudo apt install NetworkManager-tui
sudo apt install NetworkManager-wifi
sudo apt install nmap
sudo apt install pamixer
sudo apt install pandoc
sudo apt install pavucontrol
sudo apt install perl-core
sudo apt install playerctl
sudo apt install potrace
sudo apt install protontricks
sudo apt install python3-setuptools
sudo apt install qbittorrent
sudo apt install qt5ct
sudo apt install qt5-qtbase-devel
sudo apt install qt6ct
sudo apt install rpi-imager
sudo apt install slurp
sudo apt install steam
sudo apt install strawberry
sudo apt install sway
sudo apt install swaylock
sudo apt install terminus-fonts-console
sudo apt install thunar
sudo apt install thunar-archive-plugin
sudo apt install tlp
sudo apt install torbrowser-launcher
sudo apt install ufw
sudo apt install vlc
sudo apt install waybar
sudo apt install wayland-devel
sudo apt install wayland-protocols-devel
sudo apt install wdisplays
sudo apt install xdg-user-dirs
sudo apt install xsane
sudo apt install zathura
sudo apt install zathura-pdf-mupdf
#sudo mkdir /etc/systemd/logind.conf.d/
#sudo touch /etc/systemd/logind.conf.d/99-laptop-server.conf
#echo "[Login]" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
#echo "HandleLidSwitch=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
#echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
#echo "HandleLidSwitchDocked=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
#
#sudo apt -y install stow
#rm ~/.bashrc ~/.bash_profile
#stow .
#source ~/.bashrc
#
#
#sudo apt -y purge yt-dlp
#curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
#chmod a+rx ~/.local/bin/yt-dlp  # Make executable
#
#go install go.senan.xyz/cliphist@latest
#env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
#
#echo "don't add anything to path for rustup"
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#echo "don't add anything to path or enable completions for deno"
#curl -fsSL https://deno.land/install.sh | sh
#source ~/.bashrc
#deno completions bash > ~/.bashrc.d/user/deno.bash
#
### flatpaks
#sudo apt -y install flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#
#flatpak -y install flathub com.obsproject.Studio
#flatpak -y install flathub org.gnome.Epiphany
#flatpak -y install flathub org.signal.Signal
#flatpak -y install flathub org.kde.kdenlive
#flatpak -y install flathub org.mozilla.Thunderbird
#
### services
#sudo systemctl enable tlp
#sudo systemctl enable docker
#systemctl --user enable kanshi.service
#systemctl --user start sway-session.target
#echo "You should probably reboot before using this system :|"
