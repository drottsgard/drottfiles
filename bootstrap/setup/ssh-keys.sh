#!/usr/bin/env bash
set -e

SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"

BITBUCKET_KEY="$SSH_DIR/id_ed25519_bitbucket"
GITHUB_KEY="$SSH_DIR/id_ed25519_github"

BITBUCKET_EMAIL="alexander.drottsgard@eletive.com"
GITHUB_EMAIL="alexander@drottsgard.com"

# Ensure ~/.ssh exists with correct permissions
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Generate Bitbucket key (work)
if [ -f "$BITBUCKET_KEY" ]; then
	echo "Bitbucket key already exists, skipping."
else
	echo "Generating Bitbucket SSH key..."
	ssh-keygen -t ed25519 -C "$BITBUCKET_EMAIL" -f "$BITBUCKET_KEY" -N ""
	echo "Bitbucket key generated."
fi

# Generate GitHub key (personal)
if [ -f "$GITHUB_KEY" ]; then
	echo "GitHub key already exists, skipping."
else
	echo "Generating GitHub SSH key..."
	ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$GITHUB_KEY" -N ""
	echo "GitHub key generated."
fi

# Write SSH config entries if they don't already exist
touch "$SSH_CONFIG"

if ! grep -q "Host bitbucket.org" "$SSH_CONFIG" 2>/dev/null; then
	cat >> "$SSH_CONFIG" <<-EOF

	# Bitbucket (work)
	Host bitbucket.org
	    HostName bitbucket.org
	    User git
	    IdentityFile $BITBUCKET_KEY
	    IdentitiesOnly yes
	EOF
	echo "Added Bitbucket entry to SSH config."
else
	echo "Bitbucket entry already in SSH config, skipping."
fi

if ! grep -q "Host github.com" "$SSH_CONFIG" 2>/dev/null; then
	cat >> "$SSH_CONFIG" <<-EOF

	# GitHub (personal)
	Host github.com
	    HostName github.com
	    User git
	    IdentityFile $GITHUB_KEY
	    IdentitiesOnly yes
	EOF
	echo "Added GitHub entry to SSH config."
else
	echo "GitHub entry already in SSH config, skipping."
fi

# Set correct permissions
chmod 600 "$SSH_CONFIG"
chmod 600 "$BITBUCKET_KEY" "$GITHUB_KEY" 2>/dev/null || true
chmod 644 "$BITBUCKET_KEY.pub" "$GITHUB_KEY.pub" 2>/dev/null || true

echo ""
echo "=== Public keys (add these to your accounts) ==="
echo ""

if [ -f "$BITBUCKET_KEY.pub" ]; then
	echo "--- Bitbucket ($BITBUCKET_EMAIL) ---"
	cat "$BITBUCKET_KEY.pub"
	echo ""
fi

if [ -f "$GITHUB_KEY.pub" ]; then
	echo "--- GitHub ($GITHUB_EMAIL) ---"
	cat "$GITHUB_KEY.pub"
	echo ""
fi
