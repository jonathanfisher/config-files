# This is the directory of the current file.  This is important because this
# file is probably included from the main ~/.bashrc or ~/.bash_profile files.
c="$(dirname ${BASH_SOURCE[0]})"

if [ -f "$c/colors.sh" ] ; then
	. "$c/colors.sh"
fi

# Set format for prompt
# I don't have git completion working on the mac just yet.
TITLEBAR='\[\e]0;\u: \w\a\]'
case $(uname) in
    Linux)
        GITPS1='$(__git_ps1)' ;;
    *)
        GITPS1='' ;;
esac
PS1='\u:\w'"\[${Blue}\]$GITPS1\[${Color_Off}\]"
PS1="$TITLEBAR$PS1 $ "

# Used for cross-compiling for Atmel parts.
alias amake='make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-'

# Avoid clobbering files
alias mkdir='mkdir -p'

# JMF: Set aliases for clipboard access.
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# Git commands
alias gc='git commit -a -m'
alias gco='git checkout'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gm='git merge'


# Shortcut for vim
alias v='vim'

# Shortcut to go to a specific directory
alias scanner='cd ~/Projects/scannerv2'

####################################
# Create some useful commands.
####################################

# Try to extract a given file.
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf $1	;;
			*.tar.gz)	tar xvzf $1	;;
			*.tar.xz)	tar xvf $1	;;
			*.bz2)		bunzip2 $1	;;
			*.rar)		unrar x $1	;;
			*.gz)		gunzip $1	;;
			*.tar)		tar xvf $1	;;
			*.tbz2)		tar xvjf $1	;;
			*.tgz)		tar xvzf $1	;;
			*.zip)		unzip $1	;;
			*.Z)		uncompress $1	;;
			*.7z)		7z x $1		;;
			*)		echo "Don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

up() {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
	do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}
