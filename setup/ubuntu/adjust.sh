#!/bin/bash

gh auth login --with-token < /tmp/token.txt
[ ! -d ~/workspace/todo ] && gh repo clone notomo/todo ~/workspace/todo

[ ! -f "${DOTFILES}"/vim/lua/notomo/local/local.lua ] && cp "${DOTFILES}"/vim/lua/notomo/local/local.lua.sample "${DOTFILES}"/vim/lua/notomo/local/local.lua

sudo chsh -s /home/linuxbrew/.linuxbrew/bin/zsh "$(whoami)"
