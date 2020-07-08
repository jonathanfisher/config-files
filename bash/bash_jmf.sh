# If we're not running interactively, just bail now
[ -z "$PS1" ] && return

# This is the directory of the current file.  This is important because this
# file is probably included from the main ~/.bashrc or ~/.bash_profile files.
c="$(dirname ${BASH_SOURCE[0]})"

UNAME=$(uname)

if [ -f "$c/colors.sh" ] ; then
	. "$c/colors.sh"
fi

# Set up go path
export GOPATH=$HOME/go

if [ ! -d "$GOPATH" ]; then
	# Create the directory
	mkdir -p $GOPATH
fi

if ! which go > /dev/null 2>&1
then
	export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "/usr/local/texlive/2020/bin/x86_64-linux" ]
then
	export PATH=$PATH:/usr/local/texlive/2020/bin/x86_64-linux
fi

# Avoid clobbering files
alias mkdir='mkdir -p'

# Colors for ls
case $UNAME in
	Linux)
		alias ls='ls --color'
		export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
		;;
	Darwin)
		alias ls='ls -G'
		export LSCOLORS="gxfxcxdxbxegedabagacad"
		;;
esac

# Set aliases for clipboard access.
case $UNAME in
	Linux)
		alias setclip='xclip -selection c'
		alias getclip='xclip -selection clipboard -o'
		;;
	Darwin)
		alias setclip='pbcopy'
		alias getclip='pbpaste'
		;;
esac

# Shortcut for vim
alias v='vim'

# Bring in completions for hub
if [ -f "$c/hub.bash_completion.sh" ]; then
	. "$c/hub.bash_completion.sh"
fi

if [ -f "$c/git-completion.bash" ]; then
	. "$c/git-completion.bash"
fi

# Bring in the git-prompt if needed (e.g. on MacOS)
case "$UNAME" in
	Darwin|MINGW*|CYGWIN*)
		. "$c/git-prompt.sh"
		;;
esac

# Set format for prompt
# Note: this is all *very* sensitive to single- and double-quotes.
# Single quotes preserve the literal value of each character within the quotes (https://www.gnu.org/software/bash/manual/html_node/Single-Quotes.html)
# Double quotes preserve the literal value of each character within the quotes.... with the exception of
# '$', '`', '\' and, when history expansion is enabled, '!'. '*' and '@' have special meaning inside of double quotes.
# (https://www.gnu.org/software/bash/manual/html_node/Double-Quotes.html)
# GITPS1="${Cyan}"'$(unalias git; __git_ps1 " (%s)")'"${Color_Off}"
GITPS1=''
# export PS1='\[\e]0;Git Bash : \w\007\]\u@\h:\w'"${GITPS1}"' \$ '

# Default Cygwin one, with the newline removed
# export PS1='\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] \$ '

# Default Git Bash for Windows one, with newline removed
# export PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\[\033[32m\]\u@\h\[\033[35m\] \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\] $ '
# export PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\[\033[32m\]\u@\h\[\033[35m\] \[\033[33m\]\[\w\]\[\e[0m\] $ '
# export PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\[\033[32m\]\u@\h\[\033[35m\] \[\033[33m\]\w\[\033[36m\]\[\033[0m\] $ '
case $(uname -o) in
	Msys)
		PS1=''
		# PS1+='\[\e[36m\]\w\[\e[0m\] \$ ' # Works
		# PS1+='\[$Cyan\]\w\[$Color_Off\] \$ ' # Works
		
		# PS1+=$'\[\033]0;Git Bash:$PWD\007\]'
		# PS1+='\[\u\]:\[\w\] \$ '

		PS1+='\u:\[$Cyan\]\w\[$Color_Off\] \$ ' # Works
		export PS1
		;;
	Cygwin)
		PS1=''
		PS1+=$'\[\033]0;Cygwin:$PWD\007\]'
		PS1+='\u:\w \$ '
		export PS1
		;;
	*)
		echo "It's something else!"
		;;
esac

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

# Invoking `up` will move up a directory. It has an optional argument that specifies the
# number of directories to try to move up.
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

if which hub 2>&1 > /dev/null
then
	alias git='hub'
fi

# This function is used to set the environment variable used by git in the current
# terminal session. This is used in the case where you have multiple public/private
# key pairs for different GitHub identities, and want to be able to use the keys
# when appropriate.
set-git-key() {
	if [ $# -eq 1 ]
	then
		export GIT_SSH_COMMAND="ssh -i $1 -o 'IdentitiesOnly yes'"
		echo "GIT_SSH_COMMAND = $GIT_SSH_COMMAND"
	else
		unset GIT_SSH_COMMAND
		echo "Cleared GIT_SSH_COMMAND"
	fi
}