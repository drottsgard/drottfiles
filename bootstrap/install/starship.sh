#!/usr/bin/env bash
set -e

tool="starship"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."
	curl -sS https://starship.rs/install.sh | sh -s -- --yes
	echo "$tool installed successfully"
else
	echo "$tool already installed"
fi
