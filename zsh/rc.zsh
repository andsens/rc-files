#!/bin/bash
rcfiles=$HOME/.homesick/repos/rc-files

system=$("$rcfiles/system")

if [ -f ~/.custom ]; then
	source ~/.custom
fi

if [ -f ~/.localenv ]; then
	source ~/.localenv
fi

# homeshick stuff
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
# Check if castles need refreshing
homeshick --quiet refresh 14 $HOMESHICK_REFRESH_REPOS
unset HOMESHICK_REFRESH_REPOS
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

omz_dir=$HOME/.homesick/repos/oh-my-zsh
if [[ -e $omz_dir/oh-my-zsh.sh ]]; then
	export ZSH=$omz_dir
	# Let homeshick handle the updating
	DISABLE_AUTO_UPDATE="true"
	if [[ -z "$ZSH_THEME" ]]; then
		ZSH_THEME="jreese"
	fi
	plugins+=()
	if [[ $system == 'Linux' ]]; then
		plugins+=()
	fi
	if [[ $system == 'OSX' ]]; then
		plugins+=(osx)
	fi
	source "$omz_dir/oh-my-zsh.sh"
	unsetopt correct_all
	# Disable the automatic titling, it screws up tmux
	DISABLE_AUTO_TITLE=true
fi
unset omz_dir

if [[ $system == 'Linux' ]]; then
	source "$rcfiles/zsh/rc.linux.zsh"
fi
if [[ $system == 'OSX' ]]; then
	source "$rcfiles/zsh/rc.osx.zsh"
fi

source "$rcfiles/aliases"
source "$rcfiles/tools"

if [[ -f ~/.dir_colors && ( -x /usr/local/bin/dircolors || -x /usr/bin/dircolors ) ]]; then
    eval $(dircolors ~/.dir_colors)
fi

if [[ -e ~/.ssh/ssh_auth_sock ]]; then
	export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

unset rcfiles
unset system
