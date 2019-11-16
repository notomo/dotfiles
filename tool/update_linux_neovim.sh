nvim --version
mv -f ~/.local/bin/nvim ~/.local/bin/nvim.tmp
pushd ~/dotfiles/ansible
ANSIBLE_CONFIG=$(pwd) ansible-playbook playbooks/ubuntu.yml --tags neovim --ask-become-pass
nvim --version
popd
