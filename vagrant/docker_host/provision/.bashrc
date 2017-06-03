
if [ -f /etc/.bashrc ]; then
    . /etc/.bashrc
fi

# alias nvimrun="cd ~/dotfiles/docker/neovim; docker-compose run --rm neovim"
# alias nvimrunroot="cd ~/dotfiles/docker/neovim; docker-compose run --rm -u root neovim"
# alias nvimbuild="sh /vagrant/provision/nvim_build.sh"

if [ -x /usr/bin/Xvfb ] && [ -x /usr/bin/VBoxClient ] && [ ! -f /tmp/.X0-lock ]; then
    Xvfb -screen 0 320x240x8 > /dev/null 2>&1 &
    sleep 0.5
    DISPLAY=:0 VBoxClient --clipboard
fi
