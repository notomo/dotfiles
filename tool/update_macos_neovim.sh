nvim --version

install_dir=$(mise where github:neovim/neovim)
if [ -d "$install_dir" ]; then
  backup_dir="${install_dir}.backup.$(date +%Y%m%d_%H%M%S)"
  echo "Backing up $install_dir to $backup_dir"
  mv "$install_dir" "$backup_dir"
fi

pushd ~
mise install -fv github:neovim/neovim@nightly
popd
nvim --version
make -C ${DOTFILES}/vim test
