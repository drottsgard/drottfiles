#!/usr/bin/env bash
set -e

# build-essential plus additional build tools needed for compiling
# software from source (e.g., neovim requires cmake, gettext, ninja-build)
pkgs=(
	build-essential
	cmake
	curl
	gettext
	git
	ninja-build
)

echo "Installing build tools: ${pkgs[*]}..."
sudo apt-get update && sudo apt-get install -y "${pkgs[@]}"
echo "Build tools installed successfully"
