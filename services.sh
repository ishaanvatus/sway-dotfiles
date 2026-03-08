#!/bin/sh

sudo systemctl enable tlp
sudo systemctl enable docker
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://deno.land/install.sh | sh
