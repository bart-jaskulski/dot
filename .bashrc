#!/bin/bash

case $- in
  *i*) ;;
    *) return;;
esac

#------------- env ----------------

export GPG_TTY=$(tty)
export REPOS="$HOME/Repos"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim
export GITLAB_HOST='https://gitlab.wpdesk.dev'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
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
  "$HOME/bin"

#--------------- cdpath

export CDPATH=".:$REPOS:$REPOS/WPDesk"

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

__dirty_git() {
  local SCM=0
  if test -f .git/HEAD -o -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)"
	then
	  SCM=1
	fi
	if test $SCM == 1; then
	  local state commit_count m
    state=$(git status --short 2>/dev/null | wc -l)
	  commit_count=$(git rev-list --after='1 week' --count HEAD)
	  if test "$state" -gt 18; then
      m="$state uncommited changes."
    fi
	  if test "$state" -ne 0 -a "$commit_count" -eq 0; then
      m="Last change $(git log -1 --format=%cs)."
    fi
	  if test -n "$m"; then
	    echo -e "\e[31mDo you even use git? $m\e[0m"
	  fi
  fi
}

__ps1() {
    local P='$' dir="${PWD##*/}" B r='\[\e[31m\]' g='\[\e[30m\]' u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' b='\[\e[36m\]' x='\[\e[0m\]';
    [[ $EUID == 0 ]] && P='#' && u=$r && p=$u;
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
    [[ $PWD = / ]] && dir=/;
    [[ $PWD = "$HOME" ]] && dir='~';
    B=$(git branch --show-current 2>/dev/null);
    [[ $dir = "$B" ]] && B=.;
    [[ $B = master || $B = main ]] && b="$r";
    [[ -n "$B" ]] && B="$b($B)";
    PS1="$w$dir$B\n$g$p$P$x "
}

PROMPT_COMMAND="__dirty_git;__ps1"

#-------------------- keyboard --------------------

setxkbmap -option caps:shiftlock

#---------------- aliases -----------------

unalias -a
alias c=composer
alias dc='docker-compose'
alias ls='ls -h --color=auto'
alias ll='ls -al'
alias la='ls -AF'
alias _=sudo
alias x=exit
alias ..='cd ..'
alias ...='cd ../..'
alias chmox='chmod +x'
alias k='clear'
alias r=ranger
alias vi=vim
# TODO: move those aliases to git config, to free up bashrc
alias ga='git add'
alias gall='git add --all'
alias gdf='git diff'
alias gdfc='git diff --cached'
alias gs='git status'
alias gss='git stats --short'
alias gc='git commit'
alias gcv='git commit --no-verify'
alias gcm='git commit --message'
alias gcmv='git commit --no-verify --message'
alias gcaev='git commit --amend --no-edit --no-verify'
alias gsw='git switch'
alias gswc='git switch --create'
alias gl='git log --oneline'
alias gla='git log --oneline --all'
alias gm='git merge'
alias gmf='git merge --no-ff'
alias gp='git push'
alias gpo='git push origin'
alias gpl='git pull'
alias gst='git stash'
alias gstm='git stash push --message'
alias gstpo='git stash pop'
alias gstpu='git stash push'
alias gstl='git stash list'
