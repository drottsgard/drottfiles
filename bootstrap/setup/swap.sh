#!/usr/bin/env bash
set -e

SWAP_SIZE="16G"
SWAP_FILE="/swapfile"
FSTAB_ENTRY="$SWAP_FILE none swap sw 0 0"

if swapon --show | grep -q "$SWAP_FILE"; then
	echo "$SWAP_FILE is already active, skipping."
	exit 0
fi

if [ -f "$SWAP_FILE" ]; then
	echo "$SWAP_FILE already exists but is not active, activating..."
else
	echo "Creating ${SWAP_SIZE} swap file at $SWAP_FILE..."
	sudo fallocate -l "$SWAP_SIZE" "$SWAP_FILE"
fi

sudo chmod 600 "$SWAP_FILE"
sudo mkswap "$SWAP_FILE"
sudo swapon "$SWAP_FILE"
echo "Swap activated."

if grep -q "$SWAP_FILE" /etc/fstab 2>/dev/null; then
	echo "fstab entry already exists, skipping."
else
	echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null
	echo "Added swap entry to /etc/fstab."
fi

echo ""
echo "=== Swap setup complete ==="
free -h | grep -i swap
