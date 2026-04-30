#!/bin/sh


PKGS=" papirus-icon-theme arc-theme 7z blueman cage calibre chafa chromium cowsay cups dav1d ddcutil default-fonts-cjk easytag expat-devel faketime fastfetch ffmpeg-devel ffmpegthumbnailer file-roller foliate fortune-mod freerdp fuse fuse-libs fuzzel gammastep gimp gimp-resynthesizer golang google-noto-color-emoji-fonts google-noto-emoji-fonts gparted grim grimpicker gstreamer1-devel gstreamer1-plugins-bad-free-extras gstreamer1-plugins-base-devel gutenprint gutenprint-devel gvfs gvfs-mtp gvfs-smb HandBrake HandBrake-gui hplip htop hugin hw-probe ImageMagick imlib2-devel inkscape iwlwifi-mvm-firmware kanshi keepassxc kernel-devel krita libexif-devel libjxl-utils libreoffice libunrar libXcursor-devel libXft-devel libXi-devel libXinerama-devel libxkbcommon-devel libXrandr-devel light lshw lxappearance lxpolkit lz4-devel mediawriter meson mkvtoolnix mkvtoolnix-gui moreutils mpv mpv-mpris nasm ncdu network-manager-applet NetworkManager-tui NetworkManager-wifi ninja-build nmap opus-tools pamixer pandoc parallel pavucontrol perl-core perl-File-MimeInfo playerctl plymouth-theme-spinfinity potrace protontricks python3-setuptools python3-tkinter qbittorrent qpwgraph qt5-qtbase-devel qt5ct qt6ct rpi-imager slurp sox sqlitebrowser steam stow strawberry sway swaylock terminus-fonts-console thunar thunar-archive-plugin thunar-volman tlp torbrowser-launcher tree-sitter-cli ufw unrar vlc waybar waydroid wayland-devel wayland-protocols-devel wdisplays weechat xdg-user-dirs xsane zathura zathura-cb zathura-pdf-mupdf"

mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures/screenshots/mpv ~/public ~/templates ~/videos/recordings ~/src
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4 ~/.config/gtk-3.0
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

echo "max_parallel_downloads=10" | sudo tee -a  /etc/dnf/dnf.conf
sudo dnf -y upgrade --refresh

# Laptop stays on when closing lid
sudo mkdir /etc/systemd/logind.conf.d/
echo "[Login]" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitch=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a  /etc/systemd/logind.conf.d/99-laptop-server.conf
echo "HandleLidSwitchDocked=ignore" | sudo tee -a /etc/systemd/logind.conf.d/99-laptop-server.conf

# /etc/vconsole.conf
echo 'KEYMAP="us"' | sudo tee /etc/vconsole.conf
echo 'FONT="ter-132b"' | sudo tee -a /etc/vconsole.conf

# udev rules for vial for my Unicomp Mini-M
echo "# Unicomp Mini M" | sudo tee -a /etc/udev/rules.d/99-unicomp-mini-m.rules
echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", ATTRS{idVendor}==\"16c0\", ATTRS{idProduct}==\"27db\", MODE=\"0660\", GROUP=\"wheel\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" | sudo tee -a /etc/udev/rules.d/99-unicomp-mini-m.rules

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

# packages
sudo dnf -y install ${PKGS}

## browser

## librewolf
curl -fsSL https://repo.librewolf.net/librewolf.repo | sudo tee /etc/yum.repos.d/librewolf.repo
sudo dnf -y install librewolf
## mullvad
sudo dnf -y config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
sudo dnf -y install mullvad-browser


sudo dnf -y install @virtualization
sudo usermod -a -G libvirt $(whoami)

sudo dnf -y config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"

sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $(whoami)


#sudo dnf -y remove yt-dlp
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
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak -y install flathub \
    com.obsproject.Studio \
    org.gnome.Epiphany \
    org.signal.Signal \
    org.kde.kdenlive \
    org.mozilla.Thunderbird \
    io.github.ciromattia.kcc \
    org.jdownloader.JDownloader
## services
xdg-user-dirs-update

systemctl --user enable kanshi.service
systemctl --user start sway-session.target
sudo systemctl enable tlp
echo "START_CHARGE_THRESH_BAT0=40" | sudo tee -a /etc/tlp.conf
echo "STOP_CHARGE_THRESH_BAT0=60" | sudo tee -a /etc/tlp.conf
sudo systemctl enable docker

sudo systemctl set-default graphical.target
sudo grubby --update-kernel=ALL --args="rhgb quiet"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo plymouth-set-default-theme spinfinity
sudo dracut --force 

echo "rebooting in 10 seconds press <C-c> to stop"
sleep 10s

sudo systemctl reboot
