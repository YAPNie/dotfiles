# dotfiles

Personal dotfiles managed by GNU Stow.

## GNU Stow

### Requirements

- **GNU Stow v2.3.0+** (released 2019-06-29) is required for `~` (tilde)
  expansion support in `.stowrc`.

### Warnings

- Always run as a regular user to ensure symlinks are created in your home directory, or set the target directory explicitly via command-line arguments.
- Running via `sudo` will cause `~` to resolve to `/root`.

### Commands

```bash
# Dry run (show but do nothing)
stow -nv -R nvim
# Restow packages (first unstow, then stow again).
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

## Links to other dotfiles

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - A launch point for your personal nvim configuration 
- [@holman does dotfiles](https://github.com/holman/dotfiles)
- [](https://github.com/ChristopherA/dotfiles-stow/)

## Useful commands

```bash
cd ~/Projects/dotfiles
tree -a -I '.git'
```
