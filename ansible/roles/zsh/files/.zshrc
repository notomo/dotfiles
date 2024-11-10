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
setopt hist_ignore_all_dups
setopt hist_ignore_space
export HISTSIZE=1000
export SAVEHIST=100000
export HISTFILE=${HOME}/.zsh_history
setopt extended_history
setopt print_exit_value

zinit light zsh-users/zsh-completions

zshaddhistory() {
  ! [[ ${1%%$'\n'} =~ "(token|TOKEN|password|PASSWORD|secret|SECRET).*=.*" ]]
}
