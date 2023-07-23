#!/bin/bash
#--- Interactive shells only --------------------------------------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
#--- Prompt -------------------------------------------------------------------
. ~/.bashrc_colors
. ~/.bashrc_distro
. ~/.bashrc_prompt
#--- History ------------------------------------------------------------------
HISTSIZE=9999
HISTFILESIZE=9999
HISTCONTROL=ignoreboth 		# don't put duplicate lines in the history.
shopt -s histappend 		# append to the history file, don't overwrite it
shopt -s checkwinsize 		# update the values of LINES and COLUMNS.
#--- Aliases ------------------------------------------------------------------
. ~/.bashrc_alias
#--- Bash completion ----------------------------------------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#--- Environment Variable -----------------------------------------------------
export PATH=$PATH:~/mps/snippets:~/.local/bin
export EDITOR=nvim
export TERM=xterm-kitty
export SHELL=/bin/bash
export DISPLAY=:0
export XDG_CONFIG_HOME=$HOME/.config
export SYSTEMD_PAGER="cat"
export LC_ALL=de_DE.UTF-8
export LC_LANG=de_DE.UTF-8
export LANGUAGE=de_DE.UTF-8
#--- Tokens -------------------------------------------------------------------
ASKSCRIPT=~/mps/secrets/chatgpt-token.bash
[[ -f $ASKSCRIPT ]] && . $ASKSCRIPT

