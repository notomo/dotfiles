nvim --version
rm -f ~/.local/bin/nvim
mv -f ~/app/nvim.tar.gz ~/app/nvim.tar.gz.tmp
mv -f ~/app/nvim ~/app/nvim.tmp
pushd "${DOTFILES}"/ansible
ansible-playbook playbooks/mac.yml --tags neovim
nvim --version
popd
