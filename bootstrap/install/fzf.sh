#!/usr/bin/env bash
set -e

if command -v fzf &>/dev/null; then
	echo "fzf is already installed, skipping."
	exit 0
fi

sudo apt-get update -qq
sudo apt-get install -y -qq fzf
echo "fzf installed."
