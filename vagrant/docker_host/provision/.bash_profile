
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH=$HOME/.go
export GROOVY_HOME=$HOME/app/groovy/latest
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.config/composer/vendor/bin:$GOPATH/bin:/usr/local/go/bin:$GROOVY_HOME/bin
export PS1="[\u@\h \w]\$ "
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
