#!/usr/bin/env bash
set -e

tool="docker"

if ! command -v $tool &> /dev/null; then
	echo "Installing $tool..."

	# Remove conflicting packages (ignore errors if not installed)
	sudo apt-get remove -y docker.io docker-compose docker-compose-v2 \
		docker-doc podman-docker containerd runc 2>/dev/null || true

	# Set up Docker's official apt repository
	sudo apt-get update
	sudo apt-get install -y ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		-o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add repository to apt sources
	sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<-EOF
	Types: deb
	URIs: https://download.docker.com/linux/ubuntu
	Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
	Components: stable
	Signed-By: /etc/apt/keyrings/docker.asc
	EOF

	sudo apt-get update

	# Install Docker Engine + CLI + plugins (server-only, no GUI)
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
		docker-buildx-plugin docker-compose-plugin

	# Add current user to docker group (requires re-login to take effect)
	sudo groupadd -f docker
	sudo usermod -aG docker $USER

	echo "$tool installed successfully"
	echo "Note: log out and back in for docker group membership to take effect"
else
	echo "$tool already installed"
fi
