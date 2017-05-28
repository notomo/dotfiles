cd ~/dotfiles/docker/neovim
docker-compose build
docker-compose run --rm -u root --entrypoint "/home/user/dotfiles/docker/neovim/chmodown.sh" neovim
