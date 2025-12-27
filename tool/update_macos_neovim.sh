nvim --version
pushd "${DOTFILES}"
mise upgrade github:neovim/neovim@nightly
popd
nvim --version
make -C ${DOTFILES}/vim test
