#!/usr/bin/env bash
set -e

if command -v tree-sitter &>/dev/null; then
  echo "tree-sitter is already installed, skipping..."
  exit 0
fi

echo "Installing tree-sitter-cli..."

# Source nvm so npm is available in this shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

npm install -g tree-sitter-cli

echo "tree-sitter-cli installed successfully!"
