
function git_clone_from_github_wiki() {
    git clone https://github.com/"$1".wiki.git
}

function port() {
    lsof -i:$1
}

function git_remote_add_from_github() {
    git remote add upstream https://github.com/"$1".git
}

alias gob="go test -bench . -benchmem"
alias gco='git checkout -t'          # {remote}/{branch_name}
alias gd='git push --delete origin ' # {tag_name} or {branch_name}
alias create_patch='git diff --cached'
alias create_empty_commit='git commit --allow-empty -m'
alias npm_ls="npm ls" # {depended package name}
alias unfreeze="tar -zxvf"
alias symbolic_link="ln -s" # ln -s {origin} {link_name}
alias docker_build="docker build -t image_name ." # image_name=notomo/name:1.0
alias docker_run_bash="docker run --rm -it image_name bash"
alias semgrep_fix="semgrep scan --quiet --json --metrics=off --config=semgrep.yaml --use-git-ignore --autofix"
