#!/bin/sh

sudo systemctl enable --now tlp
sudo systemctl enable --now docker
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://deno.land/install.sh | sh
