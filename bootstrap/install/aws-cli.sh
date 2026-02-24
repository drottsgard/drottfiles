#!/usr/bin/env bash
set -e

tool="aws-cli"

if ! command -v aws &> /dev/null; then
	echo "Installing $tool..."

	ARCH=$(uname -m)
	case "$ARCH" in
		x86_64)  URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" ;;
		aarch64) URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" ;;
		*)       echo "Unsupported architecture: $ARCH"; exit 1 ;;
	esac

	TMPDIR=$(mktemp -d)
	curl -fsSL "$URL" -o "$TMPDIR/awscliv2.zip"
	unzip -q "$TMPDIR/awscliv2.zip" -d "$TMPDIR"
	sudo "$TMPDIR/aws/install"
	rm -rf "$TMPDIR"

	echo "$tool installed successfully"
else
	echo "$tool already installed"
fi
