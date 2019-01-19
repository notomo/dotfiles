source ~/.bashrc

PROMPT="
[%n@%m %~]
\\$ "

autoload -Uz colors
colors

autoload -U compinit
compinit

setopt prompt_subst
setopt inc_append_history
setopt no_beep
setopt ignore_eof
setopt share_history
setopt hist_ignore_dups
export HISTSIZE=1000
export SAVEHIST=100000
export HISTFILE=${HOME}/.zsh_history
setopt EXTENDED_HISTORY

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "plugins/docker", from:oh-my-zsh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
