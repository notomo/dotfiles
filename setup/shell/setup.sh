#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp --update=none "${SCRIPT_DIR}/.bash_profile" "${HOME}/.bash_profile"
cp --update=none "${SCRIPT_DIR}/.bashrc" "${HOME}/.bashrc"
cp --update=none "${SCRIPT_DIR}/.inputrc" "${HOME}/.inputrc"
cp --update=none "${SCRIPT_DIR}/.zshrc" "${HOME}/.zshrc"
cp --update=none "${SCRIPT_DIR}/.zprofile" "${HOME}/.zprofile"

mkdir -p "${HOME}/.local"
touch "${HOME}/.local/.bashrc"
touch "${HOME}/.local/.bash_profile"

brew install zsh

mkdir -p "${HOME}/.zinit"
if [ ! -d "${HOME}/.zinit/bin" ]; then
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
fi
chmod -R 755 "${HOME}/.zinit"
