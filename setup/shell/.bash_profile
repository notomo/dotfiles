export EDITOR=nvim

if [ -z "${DOTFILES}" ]; then
    export DOTFILES="${HOME}/dotfiles"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=$HOME/.local/nvim/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.luarocks/bin:$PATH
export PATH=$PATH:$HOME/bin

export VUSTED_USE_LOCAL=1

osrelease=/proc/sys/kernel/osrelease
if [[ -f ${osrelease} && "$(< ${osrelease})" == *microsoft* ]]; then 
    export LIBGL_ALWAYS_INDIRECT=1
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0

    export WSLVIEW_DEFAULT_ENGINE=powershell
    export PATH=$HOME/.local/wslu/bin:$PATH

    export BROWSER=wslview
    ulimit -c unlimited
fi

if [ -f "$HOME/.local/.bash_profile" ]; then
    source "$HOME/.local/.bash_profile"
fi
eval "$(mise activate bash)"
