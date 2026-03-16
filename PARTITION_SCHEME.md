# Fedora installer partition scheme

- /boot - 2 GiB ext4
- /boot/efi - 512 MiB efi

- lvm group encrypted with luks
    1. swap - RAM SIZE + a bit more (~1G more)  swap
    2. / - rest of space ext4
