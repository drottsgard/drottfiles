# AGENTS.md

**remote, accessed via SSH from macOS**

Dotfiles and bootstrap scripts for provisioning an Ubuntu dev environment.
Not a build/test project -- there is no application code, test suite, or CI pipeline.

## Repository layout

```
bootstrap.sh          # Entry point: runs all install/setup scripts in order
bootstrap/install/    # Idempotent tool installers (one per tool)
bootstrap/setup/      # System configuration (swap, symlinks, dev dirs, SSH keys)
dotfiles/             # Mirrors $HOME; symlinked via GNU Stow
  .zshrc
  tmux-startup.sh
  .config/tmux/tmux.conf
  .config/nvim/        # Neovim config (kickstart-based, Lua)
  .config/starship.toml
```

## Running

```bash
# Full bootstrap (idempotent, requires sudo)
bash bootstrap.sh

# Single installer
bash bootstrap/install/docker.sh

# Re-symlink dotfiles only
bash bootstrap/setup/symlinks.sh
```

There are no build, lint, or test commands. Validation is manual:
run a script and verify the tool works.

## Shell script conventions

All scripts in `bootstrap/` follow these patterns:

### Shebang and error handling

```bash
#!/usr/bin/env bash
set -e
```

Every script uses `set -e` to fail fast on errors.

### Idempotency guard

Scripts check before acting and skip if already done:

```bash
if ! command -v $tool &> /dev/null; then
    echo "Installing $tool..."
    # ... install logic ...
    echo "$tool installed successfully"
else
    echo "$tool already installed"
fi
```

Alternative patterns used: `[ -f path ]`, `[ -d path ]`, `grep -q`, `swapon --show | grep -q`.

### Indentation

- Tabs for shell scripts (the dominant style in this repo)
- Exception: a few scripts (nvim.sh, treesitter.sh) use spaces -- prefer tabs for consistency

### Naming

- Install scripts: `bootstrap/install/<tool-name>.sh` (lowercase, hyphenated)
- Setup scripts: `bootstrap/setup/<descriptive-name>.sh`
- Variable names: `UPPER_SNAKE_CASE` for constants, `lower_snake` or `tool` for locals

### Output style

- `echo "Installing $tool..."` at start
- `echo "$tool installed successfully"` or `echo "$tool already installed"` at end
- Section banners: `echo "=== Section Name ==="` for major milestones

### Error suppression

Use `2>/dev/null || true` when a failure is expected/acceptable:

```bash
sudo apt-get remove -y old-pkg 2>/dev/null || true
```

### Package installs

- `sudo apt-get update && sudo apt-get install -y <pkg>` for apt packages
- Quiet flag `-qq` used in some simpler scripts (fzf.sh, stow.sh, ripgrep.sh)

## Dotfiles conventions

### Adding a new dotfile

Place it in `dotfiles/` at the path it should appear relative to `$HOME`.
Example: `dotfiles/.config/foo/config.toml` becomes `~/.config/foo/config.toml`.
Run `stow --dir=$HOME/drottfiles --target=$HOME dotfiles` to apply.

### Neovim (Lua)

Config lives at `dotfiles/.config/nvim/`. Style settings from `.stylua.toml`:

- 2-space indent (spaces, not tabs)
- 160 column width
- Single quotes preferred
- Unix line endings
- No call parentheses (`call_parentheses = "None"`)

### Tmux

Config at `dotfiles/.config/tmux/tmux.conf`. Uses Tokyo Night color scheme.
Startup script at `dotfiles/tmux-startup.sh` creates named sessions.

### Zsh

`dotfiles/.zshrc` -- sources nvm, bun, fzf, starship. Supports local
overrides via `~/.zshrc.local`.

## Adding a new bootstrap script

1. Create `bootstrap/install/<tool>.sh` following the idempotency pattern above
2. Add it to the `scripts=()` array in `bootstrap.sh` in dependency order
3. Use tabs, `set -e`, guard with `command -v` or file existence check

## Key details for agents

- Target OS: Ubuntu (remote, accessed via SSH from macOS)
- No CI, no linter, no test framework -- just shell scripts and config files
- All scripts must be idempotent and safe to re-run
- `bootstrap.sh` runs scripts sequentially; order matters for dependencies
- Home directory is `/home/alex`, repo lives at `~/drottfiles`
- Stow package is the `dotfiles/` directory (stow target is `$HOME`)
