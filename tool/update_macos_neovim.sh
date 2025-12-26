nvim --version
rm -f ~/.local/bin/nvim
mv -f ~/app/nvim.tar.gz ~/app/nvim.tar.gz.tmp
mv -f ~/app/nvim ~/app/nvim.tmp
pushd "${DOTFILES}"
mise upgrade github:neovim/neovim@nightly
popd
nvim --version
make -C ${DOTFILES}/vim test
