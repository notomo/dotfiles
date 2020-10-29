source ~/.bashrc

PROMPT="
[%n@%m %~]
\\$ "

bindkey -e

source ~/.zinit/bin/zinit.zsh

autoload -Uz colors
colors

setopt nonomatch
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

zinit light zsh-users/zsh-completions
