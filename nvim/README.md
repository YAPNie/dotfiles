# NeoVim

For Ubuntu.

## Pre-requisite

```bash
sudo apt install git unzip gzip tar curl wget
sudo apt install python3-pip nodejs npm
# ripgrep for telescope for searching in files content (<leader>sg).
sudo apt install ripgrep
```

## Notes

- `~/.local/share/nvim/` - NeoVim data dir (stdpath "data")


## Install as AppImage

Plugins may requires more recent NeoVim versions that is it in repos. AppImage
can be used.

### Possible AppImage layouts

- For access for every user root should be used:
  - application file (chmod 755) in: `/usr/local/appimage/appname.AppImage`
  - common symlink: `/usr/local/bin/appname`
- For specific user only:
  - application file in: `~/AppImages/appname.AppImage`

Symlink can be created (dir may be not exist and not in PATH):
`~/.local/bin/appname`

### Install/ugrade AppImage

[Check the latest release version](https://github.com/neovim/neovim/releases)

```bash
cd /tmp
wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.appimage
sudo mkdir -p /usr/local/appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/appimage/nvim-0.12.2.appimage
sudo chmod 755 /usr/local/appimage/nvim-0.12.2.appimage
# Create symlink for a specific user
ln -sfn /usr/local/appimage/nvim-0.12.2.appimage ~/.local/bin/nvim
```

### Check FUSE existance

```bash
# Check the FUSE exists.
fusermount3 --version
# Check updates
#sudo apt update
# Create dir if not exists
# Note: if dir has not existed it is absent in PATH but
# it is in ~/.profile and the user should re-login to take effect
mkdir -p ~/.local/bin
# Create a user symlink.
ln -s /usr/local/appimage/nvim-0.12.2.appimage ~/.local/bin/nvim
# Check version
nvim --version
```

## Managers

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

Note. lazy.nvim, Mason add plugins after adding appropriate configuration, but do not delete plugins from the disk if configuration is removed.

### Commands

```nvim
:Lazy clean
```

```nvim
:Mason - opens a graphical status window
:MasonUpdate - updates all managed registries
:MasonInstall <package> ... - installs/re-installs the provided packages
:MasonUninstall <package> ... - uninstalls the provided packages
:MasonUninstallAll - uninstalls all packages
:MasonLog - opens the mason.nvim log file in a new tab window
```

## Extensions


#### Plugins

- folke/which-key.nvim - Useful plugin to show you pending keybinds.
- nvim-telescope/telescope.nvim - Fuzzy Finder (files, lsp, etc)
  - nvim-lua/plenary.nvim - предоставляет набор общих Lua‑функций
    (асинхронность, файловые операции, job‑API, тестирование, popup/utility
    helpers), чтобы не дублировать код в каждом плагине. Telescope и многие
    другие плагины зависят от него.
  - nvim-telescope/telescope-ui-select.nvim - переопределяет vim.ui.select так,
    чтобы системные/плагинные выборы (например, LSP code actions, выборы из
    плагинов) показывались через знакомый интерфейс Telescope (picker), с
    фильтрацией и удобной навигацией. Это улучшает UX при работе с LSP и другими
    вызовами, которые используют vim.ui.select
  - nvim-tree/nvim-web-devicons - предоставляет сопоставления расширений/имён
    файлов → глифы (Nerd Font) и цвета, которые используют file‑explorers,
    статус‑строки и другие плагины. Требование: патч‑шрифт (Nerd Font) для
    корректного отображения; без него иконки либо не покажутся, либо будут
    некорректны.
- echasnovski/mini.nvim - Collection of various small independent
  plugins/modules
- NMAC427/guess-indent.nvim — это лёгкий плагин для автоматического определения
  стиля отступов в файле (tabs vs spaces, ширина отступа) и автоматической
  установки соответствующих buffer‑опций при открытии файла. Он быстрый, написан
  на Lua и часто включён в стартовые конфиги (например, kickstart.nvim) чтобы не
  настраивать отступы вручную.
- nvim-treesitter/nvim-treesitter - это современный парсер‑фреймворк для Neovim,
  который даёт более точное подсвечивание, структурные операции (инкрементальный
  выбор, свёртки), и управляет языковыми парсерами (скачивание/компиляция). В
  корпоративной среде обратите внимание, что парсеры скачиваются и компилируются
  (нужны сетевой доступ и инструменты сборки)
