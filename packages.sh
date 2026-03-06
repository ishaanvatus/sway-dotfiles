#!/bin/sh
sudo dnf upgrade --refresh

## essentials
sudo dnf install -y 7z blueman calibre chromium cowsay cups default-fonts-cjk ffmpegthumbnailer file-roller file-roller foliate fortune-mod freerdp fuzzel gammastep gimp gimp-resynthesizer gnome-themes-extra golang grim gstreamer1-plugins-bad-free-extras gutenprint gutenprint-devel gvfs-mtp gvfs-smb hplip htop ImageMagick imlib2-devel iwlwifi-mvm-firmware kanshi keepassxc libexif-devel libjxl-utils libreoffice libXft-devel light lxappearance lxpolkit lz4-devel mediawriter moreutils mpv mpv-mpris neovim network-manager-applet NetworkManager-tui NetworkManager-wifi nmap pamixer pandoc pavucontrol perl-core playerctl potrace protontricks python3-setuptools qbittorrent qt5ct qt6ct slurp steam stow strawberry sway terminus-fonts-console thunar thunar-archive-plugin thunderbird tlp torbrowser-launcher ufw vlc waybar wayland-devel wayland-protocols-devel wdisplays xdg-user-dirs xsane zathura zathura-pdf-mupdf 

sudo dnf remove yt-dlp

