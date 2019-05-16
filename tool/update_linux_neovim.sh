nvim --version
mv -f ~/.local/bin/nvim ~/.local/bin/nvim.tmp
pushd ~/dotfiles/ansible
ansible-playbook playbooks/centos7.yml --tags neovim
nvim --version
popd
