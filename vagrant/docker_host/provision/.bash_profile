
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.config/composer/vendor/bin
export GOPATH=$HOME/.go
export PS1="[\u@\h \w]\$ "

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
