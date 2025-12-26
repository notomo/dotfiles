#!/usr/bin/env bash

set -eu

if [ ! -f "${HOME}/.gitconfig" ]; then
  cp "${DOTFILES}/setup/git/.gitconfig" "${HOME}/.gitconfig"
fi

cp "${DOTFILES}/setup/git/post-merge" "${DOTFILES}/.git/hooks/post-merge"
chmod +x "${DOTFILES}/.git/hooks/post-merge"

git config --global core.excludesfile "${DOTFILES}/setup/git/.gitignore_global"

git_user_name="${USER:-}"
if [ -z "${git_user_name}" ]; then
  read -p "input git user name: " git_user_name
fi

git_user_email="${GIT_EMAIL:-}"
if [ -z "${git_user_email}" ]; then
  read -p "input git user email: " git_user_email
fi

git config --global user.name "${git_user_name}"
git config --global user.email "${git_user_email}"
