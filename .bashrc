#!/bin/bash

case $- in
  *i*) ;;
    *) return;;
esac

# ---------------------- local utility functions ---------------------

_have()      { type "$1" &>/dev/null; }

#------------- env ----------------

export GPG_TTY=$(tty)
export REPOS="$HOME/Repos"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim
export GITLAB_HOST='https://gitlab.wpdesk.dev'
export LESS="-FXR"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export PNPM_HOME="$HOME/.local/share/pnpm"
# export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

#----------------- path ------------------------

pathappend() {
  declare arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="${PATH:+"$PATH:"}$arg"
  done
} && export pathappend

pathprepend() {
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//:"$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="$arg${PATH:+":${PATH}"}"
  done
} && export pathprepend

pathprepend "$HOME/Scripts"

pathappend "$HOME/.config/composer/vendor/bin" \
  "$HOME/go/bin" \
  "$PNPM_HOME" \
  "$HOME/bin"

#--------------- cdpath

export CDPATH=".:$REPOS"

#---------------- shell options -----------------

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s cdspell
shopt -s autocd
shopt -s dirspell

#------------------ history ---------------------

export HISTCONTORL=ignoreboth
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTIGNORE="exit:x:k:clear:history"

set -o vi
shopt -s histappend
shopt -s cmdhist

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability)

__ps1() {
  local P='$' dir B changes_count last_commit\
    r='\[\e[31m\]' g='\[\e[30m\]' u='\[\e[33m\]'\
    p='\[\e[34m\]' w='\[\e[35m\]' b='\[\e[36m\]'\
    x='\[\e[0m\]';

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u; # root
  [[ $PWD = / ]] && dir=/;
  [[ $PWD = "$HOME" ]] && dir='~';

  if [[ ! -n "$dir" ]]; then
    IFS=/;
    read -ra dirs <<< "${PWD/"$HOME"/"~"}";
    truncate=();
    for dir in "${dirs[@]:0:((${#dirs[@]} - 1))}";
    do
      if [[ "${dir:0:1}" == "." ]]; then
        truncate+=("${dir:0:2}");
      else
        truncate+=("${dir:0:1}");
      fi;
    done;
    dir="${truncate[*]}/${dirs[-1]}";
    IFS=;
  fi;

  changes_count=$(git status --porcelain 2>/dev/null | awk '{a[$1]++} END {for (pair in a) {printf("%s %d%s", pair, a[pair], (++i==length(a))?ORS:", ")}}')
  last_commit=$(git log -1 --format=%cd --date=format:%d.%m.%g 2>/dev/null || echo 0)

  B=$(git branch --show-current 2>/dev/null);
  [[ $dir = "$B" ]] && B=.;

  [[ $B = master || $B = main ]] && b="$r";
  [[ -n "$B" ]] && B="$b($B@$last_commit)$x";
  [[ -n "$changes_count" ]] && B+="$p[${changes_count}]$x";

  PS1="$w$dir$B\n$g$p$P$x "
}

PROMPT_COMMAND="__ps1"

#-------------------- keyboard --------------------

_have setxkbmap && test -n "$DISPLAY" && \
  setxkbmap -option caps:shiftlock

#---------------- aliases -----------------

unalias -a
alias c=composer
alias ls='ls -h --color=auto'
alias ll='ls -al'
alias la='ls -AF'
alias _=sudo
alias x=exit
alias ..='cd ..'
alias ...='cd ../..'
alias chmox='chmod +x'
alias temp='cd $(mktemp -d)'
alias k='clear'
alias r=ranger
alias vi=vim
alias g='git'

if [ -f "/usr/share/git/completion/git-completion.bash" ]; then
  source /usr/share/git/completion/git-completion.bash
  __git_complete g __git_main
fi

# Copied from bash skeleton to make sure we load completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

_have gh && . <(gh completion -s bash)
_have composer && . <(composer completion)
_have glab && . <(glab completion)
