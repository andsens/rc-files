#!/bin/zsh

system=$("$HOME/.homesick/repos/rc-files/system")

if [ -f $HOME/.custom ]; then
	source $HOME/.custom
fi

if [ -f $HOME/.localenv ]; then
	source $HOME/.localenv
fi

# homeshick stuff
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
# Check if castles need refreshing
homeshick --quiet refresh 56 $HOMESHICK_REFRESH_REPOS
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
fi

if [[ -f "$HOME/.homesick/repos/rc-files/zsh/rc.$system.zsh" ]]; then
	source "$HOME/.homesick/repos/rc-files/zsh/rc.$system.zsh"
fi

if [[ -e $omz_dir/oh-my-zsh.sh ]]; then
	source "$omz_dir/oh-my-zsh.sh"
	unsetopt correct_all
	# Disable the automatic titling, it screws up tmux
	DISABLE_AUTO_TITLE=true
fi
unset omz_dir

if find '/etc/profile.d/' -name '*.sh' -type f -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
	for file in /etc/profile.d/*.sh; do
		source "$file"
	done
	unset file
fi

unset rcfiles
unset system
