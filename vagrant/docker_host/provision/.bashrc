
if [ -f /etc/.bashrc ]; then
    . /etc/.bashrc
fi

alias nvimrun="cd ~/dotfiles/docker/neovim; docker-compose run --rm neovim"
