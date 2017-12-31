
if [ -f /etc/.bashrc ]; then
    . /etc/.bashrc
fi

alias nv="nvim"
alias nvu="nvim -u ~/dotfiles/vim/local/test.vim"
alias nvt="~/app/neovim/build/bin/nvim"
alias ee="exit"
alias ll="ls -la"
alias ss="source ~/.bashrc"
alias lsr="sudo systemctl restart lsyncd"
alias dps="docker ps -a"
alias dbd=docker_build
alias dr=docker_run_tmp
alias drd=docker_run_detach
alias drm=docker_remove
alias dl=docker_logs
alias di="docker images"
alias dh=docker_history
alias drmi=docker_remove_image
alias dip=docker_inspect
alias dt=docker_top
alias ds=docker_compose

function docker_latest() {
    docker ps -l -q
}

function docker_build() {
    name="$1"
    if [ "$name" == "" ]
    then
        docker build .
    else
        docker build -t "$name" .
    fi
}

function docker_run_tmp() {
    container="$1"
    if [ "$container" == "" ]
    then
        container="$(docker_latest)"
    fi
    docker run -it --rm --name tmp "$container" bash
}

function docker_run_detach() {
    docker run -d --name "$1" "$2" "$3"
}

function docker_remove() {
    container="$*"
    if [ "$container" == "" ]
    then
        container="$(docker_latest)"
    fi
    docker rm "$container"
}

function docker_logs() {
    container="$1"
    if [ "$container" == "" ]
    then
        container="$(docker_latest)"
    fi
    docker logs -ft "$1"
}

function docker_history() {
    docker history "$1"
}

function docker_remove_image() {
    docker rmi "$1"
}

function docker_inspect() {
    docker inspect "$*"
}

function docker_top() {
    docker top "$*"
}

function docker_compose() {
    docker-compose "$*"
}

alias ev="nvr --remote-tab"

if [ -x /usr/bin/Xvfb ] && [ -x /usr/bin/VBoxClient ] && [ ! -f /tmp/.X0-lock ]; then
    Xvfb -screen 0 320x240x8 > /dev/null 2>&1 &
    sleep 0.5
    DISPLAY=:0 VBoxClient --clipboard
fi

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init -)"
fi

if [ -f "$HOME/.local/.bashrc" ]; then
    source "$HOME/.local/.bashrc"
fi

