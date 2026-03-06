#!/bin/sh

sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.obsproject.Studio
flatpak install flathub org.gnome.Epiphany
flatpak install flathub org.signal.Signal
flatpak install flathub org.kde.kdenlive
