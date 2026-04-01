#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v gcp &>/dev/null; then CP=gcp; else CP=cp; fi

"$CP" --update=none "${SCRIPT_DIR}/.gitconfig" "${HOME}/.gitconfig"
"$CP" --update=none "${SCRIPT_DIR}/post-merge" "${DOTFILES}/.git/hooks/post-merge"
chmod +x "${DOTFILES}/.git/hooks/post-merge"

git config --global core.excludesfile "${DOTFILES}/setup/git/.gitignore_global"
