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
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    export HISTSIZE=0
    export SAVEHIST=0
fi
setopt extended_history
setopt print_exit_value

zinit light zsh-users/zsh-completions

zshaddhistory() {
  ! [[ ${1%%$'\n'} =~ "(token|TOKEN|password|PASSWORD|secret|SECRET).*=.*" ]]
}

_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)
