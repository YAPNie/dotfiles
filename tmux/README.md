# Tmux

[tmux](https://github.com/tmux/tmux) - is a terminal multiplexer: it enables a
number of terminals to be created, accessed, and controlled from a single
screen. tmux may be detached from a screen and continue running in the
background, then later reattached.

## Pre-requisite

It is used on Ubuntu 24 LTS.

## Installation

### Install as a system package

```bash
sudo apt install tmux
```

## Configuration

### Dir layout

- `~/.config/tmux/`

### 🛑 [DEPRECATED] Managers

**No any managers are used yet**. Saved just in case.

- [TPM](https://github.com/tmux-plugins/tpm) — Tmux Plugin Manager.

#### [Install TPM](https://github.com/tmux-plugins/tpm)

Clone TPM:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Put this at the bottom of `~/.config/tmux/tmux.conf`

```conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.config/tmux/plugins/tpm/tpm'
```

Reload TMUX environment so TPM is sourced:

```bash
# type this in terminal if tmux is already running
tmux source ~/.config/tmux.conf
```

### Commands

#### TPM

`prefix` - by default it is `Ctrl+b`.

- `prefix + I`
  - Installs new plugins from GitHub or any other git repository.
  - Refreshes TMUX environment
- `prefix + U`
  - updates plugin(s)
- `prefix + alt + u`
  - remove/uninstall plugins not on the plugin list

tmux run-shell '~/.config/tmux/plugins/tpm/scripts/update_plugin.sh'
