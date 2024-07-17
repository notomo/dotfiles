export EDITOR=nvim

if [ -z "${DOTFILES}" ]; then
    export DOTFILES="${HOME}/dotfiles"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=$HOME/.local/nvim/bin:$HOME/.local/bin:$PATH:$HOME/bin:$HOME/.cargo/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.luarocks/bin:$PATH

export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH

osrelease=/proc/sys/kernel/osrelease
if [[ -f ${osrelease} && "$(< ${osrelease})" == *microsoft* ]]; then 
    export LIBGL_ALWAYS_INDIRECT=1
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0

    export BROWSER=wslview
    ulimit -c unlimited
fi

if [ -d "/home/linuxbrew" ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.local/go/bin$PATH

export DENO_INSTALL="${HOME}/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi

if [ -d "${DOTFILES}" ]; then
    cd ${DOTFILES}
fi

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
