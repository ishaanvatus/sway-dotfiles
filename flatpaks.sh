#!/bin/sh

sudo dnf -y install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak -y install flathub com.obsproject.Studio
flatpak -y install flathub org.gnome.Epiphany
flatpak -y install flathub org.signal.Signal
flatpak -y install flathub org.kde.kdenlive
