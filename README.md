# dotfiles

Personal dotfiles managed by GNU Stow.

## GNU Stow

- Requires v2.3.0+ for tilde (~) expansion in `.stowrc`.
- Always run as a regular user (not sudo) to avoid symlinks in /root.

```bash
# Dry run
stow -nv -R nvim
# Restow (unstow + stow).
stow -R nvim
stow --restow nvim
```

## Usage

- Clone to `~/dotfiles`

```bash
git clone <your-repo-url> ~/dotfiles
```

- Run from the repository dir:

```bash
cd ~/dotfiles
stow nvim
```

## Resources

### Inspiration

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - A launch point
  for your personal nvim configuration
- [@holman does dotfiles](https://github.com/holman/dotfiles)
- [dotfiles-stow](https://github.com/ChristopherA/dotfiles-stow/)

### Guides

- [Your unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/tutorials/)
