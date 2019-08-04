if [ -f /etc/bashrc ] && [ "${BASH_SOURCE[0]}" != "" ]; then
    . /etc/bashrc
fi

alias nv="nvim"
alias nvu="NVIM_RPLUGIN_MANIFEST=$(HOME)/rplugin.vim nvim -u ~/dotfiles/vim/local/test.vim"
alias vu="vim -u ~/dotfiles/vim/local/test.vim"
alias nvU="nvim -u ~/dotfiles/vim/local/test.vim --noplugin"
alias nvt="~/app/neovim/build/bin/nvim"
alias vi="vim"
alias ee="exit"
alias ll="ls -lah"
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
alias rel='exec $SHELL -l'
alias rfl='sh ~/app/refresh_dotfiles_git.sh'
alias nv_b='sh ~/dotfiles/vim/tool/build_neovim.sh'
alias nv_i=neovim_install
alias pk=kill_process
alias less='less -N'
alias ps='ps au'
alias gc=git_clone_from_github
alias gcw=git_clone_from_github_wiki
alias wscatl=wscat_to_local
alias gra=git_remote_add_from_github
alias themis='NVIM_RPLUGIN_MANIFEST=$HOME/rplugin.vim themis'
alias npmd=npm_install_dev
alias create_patch='git diff --cached'
alias create_empty_commit='git commit --allow-empty -m'
alias apply_patch='git apply'
alias df='df -h'
alias gco='git checkout -t'          # {remote}/{branch_name}
alias gd='git push --delete origin ' # {tag_name} or {branch_name}
alias dsl="docker_compose logs -f --tail=100"
alias gob="go test -bench . -benchmem"
alias port=port
alias lns='ln -s' # {from} {to}

function port() {
    lsof -i:$1
}

function docker_latest() {
    docker ps -l -q
}

function docker_build() {
    name="$1"
    if [ "$name" == "" ]; then
        docker build .
    else
        docker build -t "$name" .
    fi
}

function docker_run_tmp() {
    container="$1"
    if [ "$container" == "" ]; then
        container="$(docker_latest)"
    fi
    docker run -it --rm --name tmp "$container" bash
}

function docker_run_detach() {
    docker run -d --name "$1" "$2" "$3"
}

function docker_remove() {
    docker rm "$@"
}

function docker_logs() {
    container="$1"
    if [ "$container" == "" ]; then
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
    docker inspect "$@"
}

function docker_top() {
    docker top "$@"
}

function docker_compose() {
    docker-compose "$@"
}

function neovim_install() {
    pushd
    cd ~/app/neovim
    sudo make install
    popd
}

function kill_process() {
    pkill -KILL -f "$1"
}

function git_clone_from_github() {
    git clone https://github.com/"$1".git
}

function git_clone_from_github_wiki() {
    git clone https://github.com/"$1".wiki.git
}

function git_remote_add_from_github() {
    git remote add upstream https://github.com/"$1".git
}

function npm_install_dev() {
    npm install --save-dev "$1"
}

function wscat_to_local() {
    wscat -o localhost:$1 -c ws://localhost:$1
}

alias ev="nvr --remote-tab"

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init -)"
fi

if [ ! -v "${IGNORE_LOCAL_FILE}" ] && [ -f "$HOME/.local/.bashrc" ]; then
    source "$HOME/.local/.bashrc"
fi

export PS1="\n[\u@\h \w]\n\$ "
