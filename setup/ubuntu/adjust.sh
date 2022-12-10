#!/bin/bash

gh auth login --git-protocol=ssh --hostname=gitHub.com
[ ! -d ~/workspace/todo ] && gh repo clone notomo/todo ~/workspace/todo

[ ! -f ~/dotfiles/vim/lua/notomo/local/local.lua ] && cp ~/dotfiles/vim/lua/notomo/local/local.lua.sample ~/dotfiles/vim/lua/notomo/local/local.lua

ANSIBLE_CONFIG=~/dotfiles/ansible ansible-playbook ~/dotfiles/ansible/playbooks/ubuntu.yml --ask-become-pass --tags gitconfig --tags default_shell
