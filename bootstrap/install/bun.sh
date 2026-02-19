#!/usr/bin/env bash
set -e

tool="bun"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."
	sudo apt-get install -y unzip
	curl -fsSL https://bun.com/install | bash
	echo "$tool installed successfully"
else
	echo "$tool already installed"
fi
