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

### Alternatives

#### [chezmoi](https://github.com/twpayne/chezmoi)

A modern, powerful alternative to GNU Stow. While Stow works perfectly for simple symlink management, consider migrating to [chezmoi](https://www.chezmoi.io/) if your setup grows.

**When to switch:**

- You need to manage different settings for different machines (e.g., online home PC vs. offline work PC).
- You need to securely store secrets, passwords, or private API keys.
- You need cross-platform support (e.g., managing dotfiles on Windows).

**Pros:**

- **Templates:** Use `{{ if ... }}` conditions inside configuration files to change behavior per machine.
- **Secret Management:** Native integration with password managers (Bitwarden, 1Password, KeePassXC) and encryption tools (`gpg`, `age`).
- **Cross-platform:** Written in Go, works flawlessly on Linux, macOS, and Windows without relying on symlinks.

**Cons:**

- **Learning Curve:** Requires learning new commands (`chezmoi add/edit/apply`) and Go template syntax.
- **No Direct Symlinks:** It copies files to its own repository directory, meaning you can't edit system configuration files directly without using `chezmoi edit`.
