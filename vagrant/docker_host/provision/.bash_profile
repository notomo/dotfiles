
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH=$HOME/.go
export GROOVY_HOME=$HOME/app/groovy/latest
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.config/composer/vendor/bin:$GOPATH/bin:/usr/local/go/bin:$GROOVY_HOME/bin:$HOME/.cargo/bin
export PS1="[\u@\h \w]\$ "

# for rustfmt: https://github.com/rust-lang-nursery/rustfmt/issues/1687
if [ -d "$HOME/.cargo" ]; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
fi

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
