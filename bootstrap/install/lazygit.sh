#!/usr/bin/env bash
set -e

tool="lazygit"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit -D -t /usr/local/bin/
	rm -f lazygit lazygit.tar.gz
	echo "$tool installed successfully"
else
	echo "$tool already installed"
fi
