#!/usr/bin/env bash

tool="opencode"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."
	curl -fsSL https://opencode.ai/install | bash || echo "Failed to install $tool, continuing..."
else
	echo "$tool already installed"
fi
