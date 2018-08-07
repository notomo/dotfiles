
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH=$HOME/.go
export GROOVY_HOME=$HOME/app/groovy/latest
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.config/composer/vendor/bin:$GOPATH/bin:/usr/local/go/bin:$GROOVY_HOME/bin:$HOME/.cargo/bin
export PS1="[\u@\h \w]\n\$ "

export PATH=$PATH:$HOME/.vim/dein/repos/github.com/thinca/vim-themis/bin
export THEMIS_VIM=nvim
export THEMIS_ARGS="-e -s --headless"
export THEMIS_PROFILE_LOG=profile.txt

# export NVIM_PYTHON_LOG_FILE=$HOME/log
# export NVIM_PYTHON_LOG_LEVEL=ERROR

# for rustfmt: https://github.com/rust-lang-nursery/rustfmt/issues/1687
if [ -d "$HOME/.cargo" ]; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
fi

if [ -d "$HOME/dotfiles" ]; then 
    cd ~/dotfiles
fi

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
