# Fedora installer partition scheme

- /boot - 2 GiB ext4
- /boot/efi - 512 MiB efi

- lvm group encrypted with luks
    1. swap - RAM SIZE + a bit more (~1G more) ([1.5x RAM](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/storage_administration_guide/ch-swapspace#tb-recommended-system-swap-space))
    2. / - rest of space ext4
