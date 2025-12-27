#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp --update=none "${SCRIPT_DIR}/.gitconfig" "${HOME}/.gitconfig"
cp --update=none "${SCRIPT_DIR}/post-merge" "${DOTFILES}/.git/hooks/post-merge"
chmod +x "${DOTFILES}/.git/hooks/post-merge"

git config --global core.excludesfile "${DOTFILES}/setup/git/.gitignore_global"
