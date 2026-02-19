#!/usr/bin/env bash
set -e

if command -v stow &>/dev/null; then
	echo "stow is already installed, skipping."
	exit 0
fi

sudo apt-get update -qq
sudo apt-get install -y -qq stow
echo "stow installed."
