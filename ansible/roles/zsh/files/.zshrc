source ~/.bashrc

PROMPT="[%n@%m %~]
\\$ "

autoload -Uz colors
colors

setopt prompt_subst
setopt inc_append_history
setopt no_beep
setopt ignore_eof

source ~/.local/zsh/antigen/antigen.zsh

antigen bundle zsh-users/zsh-completions

antigen apply
