#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Prompt for sudo password upfront so scripts can run uninterrupted
sudo -v

# Order matters: each script is safe to re-run, but dependencies
# dictate the sequence.
#
# 1. swap            – 16 GB swap file as safety net against OOM freezes
# 2. build-essential – provides make, gcc, etc. for source builds
# 3. docker          – container runtime (server-only, no GUI)
# 4. zsh             – shell + set as default
# 5. nvim            – depends on build-essential, clones via HTTPS
# 6. nvm             – node version manager (curl-based install) + LTS node
# 7. bun             – JavaScript runtime & toolkit (curl-based install)
# 8. treesitter      – tree-sitter CLI, required by nvim-treesitter (npm)
# 9. opencode        – standalone (curl-based install)
# 10. fzf            – fuzzy finder (used by zshrc for history search)
# 11. stow           – symlink manager for dotfiles
# 12. Symlinks       – links dotfiles/ into $HOME via stow
# 13. Dev dirs       – project directory structure and git identity

scripts=(
	bootstrap/setup/swap.sh
	bootstrap/install/build-essential.sh
	bootstrap/install/docker.sh
	bootstrap/install/zsh.sh
	bootstrap/install/nvim.sh
	bootstrap/install/nvm.sh
	bootstrap/install/bun.sh
	bootstrap/install/treesitter.sh
	bootstrap/install/opencode.sh
	bootstrap/install/starship.sh
	bootstrap/install/ripgrep.sh
	bootstrap/install/fzf.sh
	bootstrap/install/stow.sh
	bootstrap/setup/symlinks.sh
	bootstrap/setup/dev-dirs.sh
)

for script in "${scripts[@]}"; do
	path="$SCRIPT_DIR/$script"
	echo ""
	echo "=== Running $script ==="
	bash "$path"
done

echo ""
echo "=== Bootstrap complete ==="
