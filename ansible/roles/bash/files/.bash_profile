if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GROOVY_HOME=$HOME/app/groovy/latest
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:/usr/local/go/bin:$GROOVY_HOME/bin:$HOME/.cargo/bin

export PATH=$PATH:$HOME/.vim/minpac/pack/minpac/start/vim-themis/bin
export THEMIS_VIM=nvim
export THEMIS_ARGS="-e -s --headless"
export THEMIS_PROFILE_LOG=profile.txt

# used by firefox
export DISPLAY=:0

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.local/go/bin

# export NVIM_PYTHON_LOG_FILE=$HOME/log
# export NVIM_PYTHON_LOG_LEVEL=ERROR

export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH

# for rustfmt: https://github.com/rust-lang-nursery/rustfmt/issues/1687
if [ -d "$HOME/.cargo" ]; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
fi

if [ -d "$HOME/dotfiles" ]; then
    cd ~/dotfiles
fi

if [ ! -z "${IGNORE_LOCAL_FILE}" ] && [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
