if [ -f /etc/bashrc ] && [ "${BASH_SOURCE[0]}" != "" ]; then
    . /etc/bashrc
fi

alias nv="nvim"
alias vi="vim"
alias ee="exit"
alias ll="ls -lah"
alias ds=docker_compose
alias rel='exec $SHELL -l'
alias pk=kill_process
alias less='less -N'
alias ps='ps au'
alias gc=git_clone_from_github
alias themis='NVIM_RPLUGIN_MANIFEST=$HOME/rplugin.vim themis'
alias df='df -h'
alias dsl="docker_compose logs -f --tail=100"

function docker_compose() {
    docker compose "$@"
}

function kill_process() {
    pkill -KILL -f "$1"
}

function git_clone_from_github() {
    git clone https://github.com/"$1".git
}

alias ev="nvr --remote-tab"

if [ ! -v "${IGNORE_LOCAL_FILE}" ] && [ -f "$HOME/.local/.bashrc" ]; then
    source "$HOME/.local/.bashrc"
fi

export PS1="\n[\u@\h \w]\n\$ "
