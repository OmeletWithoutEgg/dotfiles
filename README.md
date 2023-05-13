# dotfiles

Some of my dotfiles.

## Install

1. Make sure that basic dependency software were installed, e.g. vim, zsh, curl, git.
2. Clone and use install script to put files to correct locations.
```bash
git clone https://github.com/OmeletWithoutEgg/dotfiles.git && cd dotfiles
./dot.sh install
```
If you don't want to install some of them please answer 'n' in the `[y/n]` part when `mkdir`.
3. Launch zsh to install zsh plugins via zinit.
```bash
exec zsh
```
4. Launch nvim to install neovim plugins via lazy.nvim.
```bash
nvim
```
warning: if ibus is not available, launching nvim may cause error so it might be a problem.

## Tools
DE&OS: KDE plasma on ArchLinux
Terminal: wezterm
Shell: zsh
Editor: `vim` and `nvim` (aliased to `v`)
