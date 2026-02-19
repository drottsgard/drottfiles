#!/usr/bin/env bash
set -e

DOTFILES="$HOME/drottfiles"

# Symlink everything in dotfiles/ into $HOME
stow --dir="$DOTFILES" --target="$HOME" dotfiles

echo "Dotfiles symlinked via stow."
