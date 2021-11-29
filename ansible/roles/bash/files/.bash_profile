if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GROOVY_HOME=$HOME/app/groovy/latest
export PATH=$HOME/.local/nvim/bin:$HOME/.local/bin:$PATH:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:/usr/local/go/bin:$GROOVY_HOME/bin:$HOME/.cargo/bin
# enable on wsl
# export BROWSER=wslview

export PATH=$PATH:$HOME/.vim/packages/pack/optpack/opt/vim-themis/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH
export THEMIS_VIM=nvim
export THEMIS_ARGS="-e -s --headless"
export THEMIS_PROFILE_LOG=profile.txt

export PATH=$PATH:$HOME/.vim/packages/pack/optpack/opt/gevdoc/bin
export GEVDOC_VIM=nvim
export GEVDOC_ARGS="-e -s --headless"

export PATH=$PATH:$HOME/.vim/packages/pack/optpack/opt/vusted/bin

export PATH=$PATH:$HOME/.vim/packages/pack/optpack/opt/vimonga/target/debug/

export EDITOR="nvr --remote-wait-silent"
export GIT_EDITOR="nvr --remote-wait-silent"

# used by firefox
export DISPLAY=:0

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.local/go/bin

export PATH=${HOME}/app/flutter/bin:$PATH
export PATH=${HOME}/app/flutter/bin/cache/dart-sdk/bin:$PATH

# export NVIM_PYTHON_LOG_FILE=$HOME/log
# export NVIM_PYTHON_LOG_LEVEL=ERROR

export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH

# for rustfmt: https://github.com/rust-lang-nursery/rustfmt/issues/1687
if [ -d "$HOME/.cargo" ]; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
fi

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init -)"
fi

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

if [[ "$(< /proc/sys/kernel/osrelease)" == *microsoft* ]]; then 
    export LIBGL_ALWAYS_INDIRECT=1
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0
fi

if [ -d "$HOME/dotfiles" ]; then
    cd ~/dotfiles
fi

if [ ! -v "${IGNORE_LOCAL_FILE}" ] && [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi

export DENO_INSTALL="${HOME}/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
