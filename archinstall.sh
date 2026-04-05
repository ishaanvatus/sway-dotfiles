### DISCLAIMER: I just asked gemini to convert the fedora install.sh (that I wrote myself) into Arch equivalents
#!/bin/sh

# 1. ARCH OFFICIAL PACKAGES (Translated from Fedora list)
ARCH_PKGS="p7zip blueman cage calibre chafa chromium cowsay cups ddcutil noto-fonts-cjk easytag libfaketime fastfetch ffmpeg ffmpegthumbnailer file-roller foliate fortune-mod freerdp fuzzel gammastep gimp gnome-themes-extra go noto-fonts-emoji gparted grim gst-plugins-bad gutenprint gvfs gvfs-mtp gvfs-smb handbrake hplip htop imagemagick imlib2 kanshi keepassxc linux-headers libexif libjxl libreoffice-fresh libxft light lxappearance polkit-gnome lz4 mkvtoolnix-cli mkvtoolnix-gui moreutils mpv mpv-mpris nasm ncdu network-manager-applet nmap opus-tools pamixer pandoc-cli pavucontrol perl perl-file-mimeinfo playerctl potrace python-setuptools tk qbittorrent qt5ct qt6ct rpi-imager slurp sqlitebrowser steam stow strawberry sway swaylock terminus-font thunar thunar-archive-plugin thunar-volman tlp torbrowser-launcher tree-sitter-cli ufw vlc waybar wdisplays xdg-user-dirs xsane zathura zathura-pdf-mupdf intel-media-driver sddm docker docker-compose libvirt qemu-desktop virt-manager dnsmasq flatpak rustup deno"

# 2. AUR PACKAGES
AUR_PKGS="gimp-plugin-resynthesizer grimpicker librewolf-bin mullvad-browser-bin plymouth plymouth-theme-hot-dog-git"

# Create directories
mkdir -p ~/desktop ~/documents ~/downloads ~/music ~/pictures/screenshots/mpv ~/public ~/templates ~/videos ~/src
mkdir -p ~/.local/share/fonts/Mononoki ~/.local/bin ~/.local/src ~/.local/share/applications ~/.config/xfce4

# Extract fonts and link mimeapps
tar xf ~/.dotfiles/Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki
ln -sf $HOME/.dotfiles/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

# Optimize Pacman (Parallel downloads, Color, ILoveCandy)
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#Color/Color\nILoveCandy/' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# Systemd logind tweaks
sudo mkdir -p /etc/systemd/logind.conf.d/
echo -e "[Login]\nHandleLidSwitch=ignore\nHandleLidSwitchExternalPower=ignore\nHandleLidSwitchDocked=ignore" | sudo tee /etc/systemd/logind.conf.d/99-laptop-server.conf

# Udev rules for Unicomp Mini M
echo "# Unicomp Mini M" | sudo tee /etc/udev/rules.d/99-unicomp-mini-m.rules
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="27db", MODE="0660", GROUP="wheel", TAG+="uaccess", TAG+="udev-acl"' | sudo tee -a /etc/udev/rules.d/99-unicomp-mini-m.rules

# Stow dotfiles
sudo pacman -S --needed --noconfirm stow
rm -f ~/.bashrc ~/.bash_profile
stow .
source ~/.bashrc

# Install official packages
sudo pacman -S --needed --noconfirm ${ARCH_PKGS}

# Install YAY (AUR Helper)
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git ~/.local/src/yay-bin
    cd ~/.local/src/yay-bin
    makepkg -si --noconfirm
    cd -
fi

# Install AUR packages (Mullvad, Librewolf, Plymouth, etc.)
yay -S --needed --noconfirm ${AUR_PKGS}

# Setup user groups for Virtualization and Docker
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG docker $(whoami)

# yt-dlp (Arch repo version is usually fine, but keeping your manual pull)
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
chmod a+rx ~/.local/bin/yt-dlp

# Go packages
go install go.senan.xyz/cliphist@latest
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

# Deno completions
deno completions bash > ~/.bashrc.d/user/deno.bash

# Flatpaks
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak -y install flathub \
    com.obsproject.Studio \
    org.gnome.Epiphany \
    org.signal.Signal \
    org.kde.kdenlive \
    org.mozilla.Thunderbird \
    io.github.ciromattia.kcc \
    org.jdownloader.JDownloader

# User dirs
xdg-user-dirs-update

# Enable services
systemctl --user enable kanshi.service
systemctl --user enable sway-session.target
sudo systemctl enable tlp
echo -e "START_CHARGE_THRESH_BAT0=40\nSTOP_CHARGE_THRESH_BAT0=60" | sudo tee -a /etc/tlp.conf
sudo systemctl enable docker
sudo systemctl enable libvirtd
sudo systemctl enable sddm
sudo systemctl set-default graphical.target

# Plymouth setup (Requires mkinitcpio regeneration in Arch)
sudo plymouth-set-default-theme -R hot-dog

echo "Post-install complete. Rebooting in 5 seconds. Press <C-c> to stop."
sleep 5
sudo systemctl reboot
