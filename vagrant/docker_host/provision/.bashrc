
if [ -f /etc/.bashrc ]; then
    . /etc/.bashrc
fi

alias nv="nvim"
alias nvu="nvim -u ~/test.vim"
alias ee="exit"
alias ll="ls -la"
alias ss="source ~/.bashrc"

if [ -x /usr/bin/Xvfb ] && [ -x /usr/bin/VBoxClient ] && [ ! -f /tmp/.X0-lock ]; then
    Xvfb -screen 0 320x240x8 > /dev/null 2>&1 &
    sleep 0.5
    DISPLAY=:0 VBoxClient --clipboard
fi

if [ -f "$HOME/.local/.bashrc" ]; then
    source "$HOME/.local/.bashrc"
fi

