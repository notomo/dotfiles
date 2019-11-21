#!/bin/bash

$HOME/.local/bin/nvim --version
mv -f $HOME/.local/bin/nvim $HOME/.local/bin/nvim.tmp
mv -f $HOME/app/nvim $HOME/app/nvim.tmp
mv -f $HOME/app/nvim.tar.gz $HOME/app/nvim.tar.gz.tmp
pushd $HOME/dotfiles/ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml --tags neovim --ask-become-pass
$HOME/.local/bin/nvim --version
popd
