#!/usr/bin/env bash
set -e

if command -v rg &>/dev/null; then
	echo "ripgrep is already installed, skipping."
	exit 0
fi

sudo apt-get update -qq
sudo apt-get install -y -qq ripgrep
echo "ripgrep installed."
