
function git_clone_from_github_wiki() {
    git clone https://github.com/"$1".wiki.git
}

function wscat_to_local() {
    wscat -o localhost:$1 -c ws://localhost:$1
}

function port() {
    lsof -i:$1
}

function git_remote_add_from_github() {
    git remote add upstream https://github.com/"$1".git
}

alias lns='ln -s' # {from} {to}
alias gob="go test -bench . -benchmem"
alias gco='git checkout -t'          # {remote}/{branch_name}
alias gd='git push --delete origin ' # {tag_name} or {branch_name}
alias apply_patch='git apply'
alias create_patch='git diff --cached'
alias create_empty_commit='git commit --allow-empty -m'
alias nvU="nvim -u ~/dotfiles/vim/local/test.vim --noplugin"
alias vu="vim -u ~/dotfiles/vim/local/test.vim"
alias nvimtags="ctags --languages=C,C++,Lua -R -I EXTERN -I INIT --exclude=.git src build/include build/src/nvim/auto .deps/build/src"
alias nvbuild="VIMRUNTIME=$HOME/workspace/neovim/runtime ~/workspace/neovim/build/bin/nvim"
alias unfreeze="tar -zxvf"
alias symbolic_link="ln -s" # ln -s {origin} {link_name}
alias docker_build="docker build -t image_name ." # image_name=notomo/name:1.0
alias docker_run_bash="docker run --rm -it image_name bash"
alias create_repo="gh repo create --public" # arg=name
alias for_coredump="ulimit -c unlimited"
# alias shutdown="wsl --shutdown"
