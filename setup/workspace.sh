#!/bin/bash
set -eu
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/app"
touch "$HOME/.sudo_as_admin_successful"

mkdir -p "$HOME/.config/nvim"

DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/notomo/dotfiles.git "$DOTFILES_DIR"
fi

ln -sf "$DOTFILES_DIR/vim/lua" "$HOME/.config/nvim/lua"
ln -sf "$DOTFILES_DIR/vim/snippets" "$HOME/.config/nvim/snippets"
ln -sf "$DOTFILES_DIR/vim/lua/notomo/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -sf "$DOTFILES_DIR/tool/.procs.toml" "$HOME/.procs.toml"
mkdir -p "$HOME/.config/wezterm"
ln -sf "$DOTFILES_DIR/tool/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
if command -v gcp &>/dev/null; then CP=gcp; else CP=cp; fi
"$CP" --update=none "$DOTFILES_DIR/vim/lua/notomo/local/local.lua.sample" "$DOTFILES_DIR/vim/lua/notomo/local/local.lua"
mkdir -p "$HOME/.config/karabiner"
"$CP" --update=none "$DOTFILES_DIR/setup/mac/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
