#!/usr/bin/env bash
set -e

tool="zsh"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."
	sudo apt-get update && sudo apt-get install -y zsh
	echo "$tool installed successfully"
else
	echo "$tool already installed"
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
	echo "Setting zsh as default shell..."
	chsh -s "$(which zsh)"
	echo "Default shell set to zsh (takes effect on next login)"
else
	echo "zsh is already the default shell"
fi
