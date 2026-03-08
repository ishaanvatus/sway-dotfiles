#!/bin/sh

source "$HOME/.cargo/env"
source "$HOME/.deno/env"
source "$HOME/.bashrc.d/user/git-completion.bash"
source "$HOME/.local/share/bash-completion/completions/deno.bash"
fortune -s | cowsay -y
