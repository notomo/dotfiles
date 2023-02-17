if [ -f /etc/bashrc ] && [ "${BASH_SOURCE[0]}" != "" ]; then
    . /etc/bashrc
fi

alias nv="nvim"
alias nvim="${EDITOR}"
alias vi="vim"
alias ee="exit"
alias ll="ls -lah"
alias ds=docker_compose
alias rel='exec $SHELL -l'
alias pk=kill_process
alias less='less -N'
alias ps='ps au'
alias df='df -h'
alias dsl="docker_compose logs -f --tail=100"
alias nvb="VIMRUNTIME=$HOME/workspace/neovim/runtime ~/workspace/neovim/build/bin/nvim"

function docker_compose() {
    docker compose "$@"
}

function kill_process() {
    pkill -KILL -f "$1"
}

if [ -f "$HOME/.local/.bashrc" ]; then
    source "$HOME/.local/.bashrc"
fi

export PS1="\n[\u@\h \w]\n\$ "
