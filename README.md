## Goal

Be able to bootstrap a Ubuntu dev environment

## Notes

I use a Macbook Pro but SSH to remote Ubuntu environment

## dotfiles/

Mirrors `$HOME`. Everything in `dotfiles/` is symlinked into `~` via
[GNU Stow](https://www.gnu.org/software/stow/) during bootstrap.

To add a new dotfile, place it in `dotfiles/` at the path it should
appear relative to `$HOME` (e.g. `dotfiles/.zshrc` -> `~/.zshrc`).

## bootstrap/install

This is where installations live

## bootstrap/setup

This is where other setups are done.
E.g. setting up ssh keys, creating development directories
