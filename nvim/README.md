# NeoVim

It was created on Ubuntu 24 LTS.

## Pre-requisite

The pre-requisites are depend on NeoVim and the used extensions.

```bash
# For lazy.nvim
sudo apt install git unzip gzip tar curl wget
# For HereRocks (lazy.nvim)
sudo apt install python3 python3-pip build-essential unzip curl
# For Mason
sudo apt install python3-pip
# For Mason (pyright, pylsp)
sudo apt install nodejs npm
# For telescope (<leader>sg) - searching in files content.
sudo apt install ripgrep fd-find
```

## Installation

### Install as a system package

If a system repo contains the package

Plugins may requires more recent NeoVim versions that is it in repos. AppImage
can be used.

### Install as an AppImage

Plugins may requires more recent NeoVim versions that is it in repos. AppImage
can be used instead of a system package.

#### Possible AppImage layouts

- For access for every user root should be used:
  - application file (chmod 755) in: `/usr/local/appimage/appname.AppImage`
  - common symlink: `/usr/local/bin/appname`
- For specific user only:
  - application file in: `~/AppImages/appname.AppImage`

Symlink can be created (dir may be not exist and not in PATH):
`~/.local/bin/appname`

#### Install/upgrade AppImage

[Check the latest release version](https://github.com/neovim/neovim/releases)

```bash
# Pre-requisites
# Check the FUSE exists (required for AppImage).
fusermount3 --version
# Create dir for AppImages
sudo mkdir -p /usr/local/appimage
# Note: if dir has not existed it is absent in PATH but
# it is in ~/.profile and the user should re-login to take effect
mkdir -p ~/.local/bin
# Install/upgrade
cd /tmp
export TMP_NVIM_VER="0.11.7"
wget https://github.com/neovim/neovim/releases/download/v${TMP_NVIM_VER}/nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/appimage/nvim-${TMP_NVIM_VER}.appimage
sudo chmod 755 /usr/local/appimage/nvim-${TMP_NVIM_VER}.appimage
# Create symlink for a specific user
ln -sfn /usr/local/appimage/nvim-${TMP_NVIM_VER}.appimage ~/.local/bin/nvim
# Check NeoVIM version
nvim --version
```

## Configuration

### Dir layout

- `~/.local/share/nvim/` - NeoVim data dir (stdpath "data"). Its content can be
  transfered to the similar another workstation but username should be the same.

### Managers

- [lazy.nvim](https://github.com/folke/lazy.nvim) — A modern plugin manager for
  Neovim. Manages Lua-scripts for NeoVIM.
- [mason.nvim](https://github.com/mason-org/mason.nvim) — Portable package
  manager for Neovim that runs everywhere Neovim runs. Easily install and manage
  LSP servers, DAP servers, linters, and formatters.
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
  — lightweight extension to mason.nvim that automatically ensures the
  installation and updating of a set of external tools (LSP, formatters,
  debuggers, CLI) according to the ensure_installed list. It doesn't replace
  mason, but rather uses its API and simplifies maintaining a consistent
  environment across different machines.

Note. lazy.nvim, Mason add plugins after adding appropriate configuration, but
do not delete plugins from the disk if configuration is removed.

### Telescope plugins specific configuration

In Ubuntu/Debian distributions, due to a name conflict, the binary file of the
utility is called `fdfind` while Telescope searches for the `fd` command by
default. To make Telescope (and Neovim itself) see the utility immediately,
create a system link (symlink) for it in your local binaries folder. This can be
done without root rights:

```bash
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
```

### Commands

#### Make load and compile everything

Make to install:

- `ensure_installed` list from `mason-tool-installer.lua`
- `ensure_installed` list from `nvim-treesitter.lua`

```bash
nvim --headless \
  "+Lazy! sync" \
  "+MasonInstall pyright ruff lua-language-server tree-sitter-cli" \
  "+TSInstall bash c diff html lua luadoc markdown markdown_inline python query regex ruby vim vimdoc" \
  "+qa"
```

#### Lazy.nvim

```nvim
:Lazy clean
```

#### Mason

```nvim
:Mason - opens a graphical status window
:MasonUpdate - updates all managed registries
:MasonInstall <package> ... - installs/re-installs the provided packages
:MasonUninstall <package> ... - uninstalls the provided packages
:MasonUninstallAll - uninstalls all packages
:MasonLog - opens the mason.nvim log file in a new tab window
```

## Plugins

- folke/which-key.nvim — Displays pending keybindings as you type.
- nvim-telescope/telescope.nvim — Fuzzy Finder (files, LSP, and more).
  - nvim-lua/plenary.nvim — Provides a set of common Lua utilities
    (asynchronous operations, file I/O, job API, testing, popup/utility helpers)
    to avoid code duplication in every plugin. Telescope and many other plugins
    depend on it.
  - nvim-telescope/telescope-ui-select.nvim — Overrides `vim.ui.select` so that
    system/plugin selection dialogs (e.g., LSP code actions, plugin pickers) are
    displayed through the familiar Telescope picker with filtering and easy
    navigation. This improves the UX when working with LSP and other features
    that rely on `vim.ui.select`.
  - nvim-tree/nvim-web-devicons — Provides file extension/name → glyph (Nerd
    Font) and color mappings used by file explorers, statuslines, and other
    plugins. Requires a patched Nerd Font to display correctly; without one,
    icons will be missing or garbled.
- echasnovski/mini.nvim — A collection of various small, independent
  plugins/modules.
- NMAC427/guess-indent.nvim — A lightweight plugin that automatically detects
  the indentation style (tabs vs spaces, indent width) in a file and sets the
  corresponding buffer options when the file is opened. It is fast, written in
  Lua, and often included in starter configurations (e.g., kickstart.nvim) to
  avoid manual indentation setup.
- nvim-treesitter/nvim-treesitter — A modern parser framework for Neovim that
  provides more accurate syntax highlighting, structural operations
  (incremental selection, code folding), and manages language parsers
  (downloading and compilation). In corporate environments, note that parsers
  are downloaded and compiled on the fly (requires network access and build
  tools).

## Maintenance

### Move to another PC

Pay attention that some managers/plugins can use absolute path in its configs.
One of the options is to use the same username on source and destination PC.
The p-option for tar can help keep and restore mode of the files.

```bash
# Archive
cd ~
tar -czpf neovim-$(nvim --version | head -n 1 | awk '{print $2}')-share-state-cache-$(whoami)-$(date +%Y%m%d).tar.gz \
    .local/share/nvim \
    .local/state/nvim \
    .cache/nvim
# UnArchive
cd ~
rm -Rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
tar -xzvpf neovim-v0.12.2-share-state-cache-oxidized-20260531.tar.gz -C ~
```
