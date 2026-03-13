#!/bin/sh

source "$HOME/.cargo/env"
source "$HOME/.deno/env"
source "$HOME/.bashrc.d/user/git-completion.bash"
source "$HOME/.bashrc.d/user/deno.bash"
source "$HOME/.bashrc.d/user/lf.bash"
fortune -s | cowsay -y
