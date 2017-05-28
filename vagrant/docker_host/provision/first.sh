git clone https://github.com/tmn-o3/dotfiles.git
sh ~/dotfiles/link.sh
cd ~/dotfiles/docker/neovim
docker-compose build
source ~/.bash_profile
source ~/.bashrc
