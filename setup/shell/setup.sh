#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v gcp &>/dev/null; then CP=gcp; else CP=cp; fi

"$CP" --update=none "${SCRIPT_DIR}/.bash_profile" "${HOME}/.bash_profile"
"$CP" --update=none "${SCRIPT_DIR}/.bashrc" "${HOME}/.bashrc"
"$CP" --update=none "${SCRIPT_DIR}/.inputrc" "${HOME}/.inputrc"
"$CP" --update=none "${SCRIPT_DIR}/.zshrc" "${HOME}/.zshrc"
"$CP" --update=none "${SCRIPT_DIR}/.zprofile" "${HOME}/.zprofile"

mkdir -p "${HOME}/.local"
touch "${HOME}/.local/.bashrc"
touch "${HOME}/.local/.bash_profile"

mkdir -p "${HOME}/.zinit"
if [ ! -d "${HOME}/.zinit/bin" ]; then
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
fi
chmod -R 755 "${HOME}/.zinit"
