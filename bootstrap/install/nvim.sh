#!/usr/bin/env bash
set -e

tool="neovim"

if ! command -v nvim &> /dev/null; then
    echo "Installing $tool..."
    if ! [ -d $HOME/build/neovim ]; then
        git clone https://github.com/neovim/neovim ~/build/neovim
    fi
    cd ~/build/neovim/
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    echo "$tool installed successfully"
else
    echo "$tool already installed"
fi
