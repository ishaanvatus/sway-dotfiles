#!/bin/sh

flatpak -y install flathub \
    com.obsproject.Studio \
    org.gnome.Epiphany \
    org.signal.Signal \
    io.github.ciromattia.kcc \
    flatpak run org.mozilla.thunderbird_esr
