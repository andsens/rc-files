#!/bin/zsh
export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxegedabagacad"

bindkey "^[[3~" delete-char

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

# Prevent '._' files from being tared
alias tar='COPYFILE_DISABLE=true tar'

plugins+=(osx)
