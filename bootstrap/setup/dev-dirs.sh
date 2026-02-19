#!/usr/bin/env bash
set -e

GIT_NAME="Alexander Drottsgård"

ELETIVE_DIR="$HOME/dev/eletive"
ELETIVE_EMAIL="alexander.drottsgard@eletive.com"

DROTTSGARD_DIR="$HOME/dev/drottsgard"
DROTTSGARD_EMAIL="alexander@drottsgard.com"

GLOBAL_GITCONFIG="$HOME/.gitconfig"

# Create development directories
for dir in "$ELETIVE_DIR" "$DROTTSGARD_DIR"; do
	if [ -d "$dir" ]; then
		echo "$dir already exists, skipping."
	else
		mkdir -p "$dir"
		echo "Created $dir"
	fi
done

# Write per-directory .gitconfig files
if [ -f "$ELETIVE_DIR/.gitconfig" ]; then
	echo "$ELETIVE_DIR/.gitconfig already exists, skipping."
else
	cat > "$ELETIVE_DIR/.gitconfig" <<-EOF
	[user]
	    name = $GIT_NAME
	    email = $ELETIVE_EMAIL
	[pull]
	    rebase = true
	[core]
	    hooksPath = ~/dev/eletive/.hooks
	EOF
	echo "Created $ELETIVE_DIR/.gitconfig"
fi

if [ -f "$DROTTSGARD_DIR/.gitconfig" ]; then
	echo "$DROTTSGARD_DIR/.gitconfig already exists, skipping."
else
	cat > "$DROTTSGARD_DIR/.gitconfig" <<-EOF
	[user]
	    name = $GIT_NAME
	    email = $DROTTSGARD_EMAIL
	[pull]
	    rebase = true
	EOF
	echo "Created $DROTTSGARD_DIR/.gitconfig"
fi

# Append includeIf entries to ~/.gitconfig
touch "$GLOBAL_GITCONFIG"

if ! grep -q "gitdir:~/dev/eletive/" "$GLOBAL_GITCONFIG" 2>/dev/null; then
	cat >> "$GLOBAL_GITCONFIG" <<-EOF

	[includeIf "gitdir:~/dev/eletive/"]
	    path = ~/dev/eletive/.gitconfig
	EOF
	echo "Added eletive includeIf to ~/.gitconfig"
else
	echo "eletive includeIf already in ~/.gitconfig, skipping."
fi

if ! grep -q "gitdir:~/dev/drottsgard/" "$GLOBAL_GITCONFIG" 2>/dev/null; then
	cat >> "$GLOBAL_GITCONFIG" <<-EOF

	[includeIf "gitdir:~/dev/drottsgard/"]
	    path = ~/dev/drottsgard/.gitconfig
	EOF
	echo "Added drottsgard includeIf to ~/.gitconfig"
else
	echo "drottsgard includeIf already in ~/.gitconfig, skipping."
fi

echo ""
echo "=== Setup complete ==="
echo "Repos cloned into ~/dev/eletive/ will use: $ELETIVE_EMAIL"
echo "Repos cloned into ~/dev/drottsgard/ will use: $DROTTSGARD_EMAIL"
