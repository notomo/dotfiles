nvim --version
pushd "${DOTFILES}"
mise install -fv github:neovim/neovim@nightly
popd
nvim --version
make -C ${DOTFILES}/vim test
