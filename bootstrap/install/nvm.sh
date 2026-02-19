#!/usr/bin/env bash
set -e

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	echo "Installing nvm..."
	PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

	# Source nvm so we can use it immediately
	. "$NVM_DIR/nvm.sh"

	echo "Installing latest LTS Node.js..."
	nvm install --lts

	echo "nvm installed successfully"
else
	echo "nvm already installed"
fi
