#!/bin/sh

PKGS="7z blueman cage calibre chafa chromium cowsay cups ddcutil default-fonts-cjk fastfetch ffmpegthumbnailer file-roller fortune-mod freerdp fuzzel gammastep gimp gimp-resynthesizer gnome-themes-extra golang gparted grim grimpicker gstreamer1-plugins-bad-free-extras gutenprint gutenprint-devel gvfs-mtp gvfs-smb HandBrake HandBrake-gui hplip htop ImageMagick imlib2-devel iwlwifi-mvm-firmware kanshi keepassxc libexif-devel libjxl-utils libreoffice libXft-devel light lxappearance lxpolkit lz4-devel mediawriter mkvtoolnix mkvtoolnix-gui moreutils mpv mpv-mpris ncdu neovim network-manager-applet NetworkManager-tui NetworkManager-wifi nmap pamixer pandoc pavucontrol perl-core playerctl potrace protontricks python3-setuptools qbittorrent qt5ct qt6ct rpi-imager slurp steam stow strawberry sway swaylock terminus-fonts-console thunar thunar-archive-plugin tlp torbrowser-launcher ufw vlc waybar wayland-devel wayland-protocols-devel wdisplays xdg-user-dirs xsane zathura zathura-pdf-mupdf"

mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures ~/public ~/templates ~/videos
mkdir -p ~/games
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4 
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

echo "fastestmirror=True" | sudo tee -a  /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" | sudo tee -a  /etc/dnf/dnf.conf
sudo dnf -y upgrade --refresh

sudo mkdir /etc/systemd/logind.conf.d/
sudo touch /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "[Login]" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitch=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchDocked=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf

sudo dnf -y install stow
rm ~/.bashrc ~/.bash_profile
stow .
source ~/.bashrc


## rpm fusion
sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
sudo dnf -y install @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -y install intel-media-driver 

## packages
sudo dnf -y install ${PKGS}

## browser

## librewolf
curl -fsSL https://repo.librewolf.net/librewolf.repo | pkexec tee /etc/yum.repos.d/librewolf.repo
sudo dnf -y install librewolf
# mullvad
sudo dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
sudo dnf install mullvad-browser


sudo dnf -y install @virtualization
sudo usermod -a -G libvirt $(whoami)

sudo dnf -y config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"

sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $(whoami)


## essentials

sudo dnf -y remove yt-dlp
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
sudo dnf -y install flatpak
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
