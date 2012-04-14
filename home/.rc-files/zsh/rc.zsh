#!/bin/zsh
system=`uname`

rcfiles=$(dirname $(dirname $_))

if [ -f ~/.localenv ]; then
	. ~/.localenv
fi

## auto-fu.zsh stuff.
# source auto-fu.zsh
# { . $rcfiles/zsh/auto-fu/auto-fu; auto-fu-install; }
# zstyle ':auto-fu:highlight' input bold
# zstyle ':auto-fu:highlight' completion fg=black,bold
# zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
# zstyle ':auto-fu:var' postdisplay $''
# zstyle ':auto-fu:var' track-keymap-skip opp
# zle-line-init () {auto-fu-init;}; zle -N zle-line-init
# zle -N zle-keymap-select auto-fu-zle-keymap-select

if [[ -e ~/.oh-my-zsh/oh-my-zsh.sh ]] then
	export ZSH=$HOME/.oh-my-zsh
	if [[ -z "$ZSH_THEME" ]] then
		export ZSH_THEME="jreese"
	fi
	plugins+=(ant extract history-substring-search svn)
	if [[ $system == 'Linux' ]]; then
		plugins+=()
	fi
	if [[ $system == 'Darwin' ]]; then
		plugins+=(brew terminalapp osx)
	fi
	. ~/.oh-my-zsh/oh-my-zsh.sh
	unsetopt correct_all
	# Disable the automatic titling, it screws up tmux
	DISABLE_AUTO_TITLE=true
fi

if [[ $system == 'Linux' ]]; then
	. $rcfiles/zsh/rc.linux.zsh
fi
if [[ $system == 'Darwin' ]]; then
	. $rcfiles/zsh/rc.osx.zsh
fi

. $rcfiles/aliases

if [[ -f ~/.dir_colors && ( -x /usr/local/bin/dircolors || -x /usr/bin/dircolors ) ]]; then
    eval `dircolors ~/.dir_colors`
fi

if [[ -e ~/.ssh/ssh_auth_sock ]] then
	export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

compile-zshrc () {
	rcfiles=$(dirname `readlink "$HOME/.zshrc"`)
	if [[ -z $rcfiles ]]; then
		echo "Cannot determine rcfiles location" >&2
		return
	fi
	if [[ -n $1 && $1 == "clean" ]]; then
		find $rcfiles -name '*.zwc' -delete
		echo 'All *.zwc files removed'
	fi;
	for file in `find $rcfiles -name '*.zsh' -type f -print`; do
		zcompile $file
	done
}

unset rcfiles
unset system
