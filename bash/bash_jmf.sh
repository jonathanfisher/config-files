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

if [ -f /etc/arch-release ]; then
    GITPS1=''
fi

PS1='\u@\h:\w'"\[${Blue}\]$GITPS1\[${Color_Off}\]"
PS1="$TITLEBAR$PS1 $ "

# Used for cross-compiling for Atmel parts.
alias amake='make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-'

# Set up go path
export GOPATH=$HOME/code/go

if [ ! -d "$GOPATH" ]; then
    # Create the directory
    mkdir -p $GOPATH
fi

# Avoid clobbering files
alias mkdir='mkdir -p'

# Colors for ls
alias ls='ls --color'

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

# Alias for Jeeves
alias jeeves='ssh jfisher@jeeves.local'

# Shortcut for vim
alias v='vim'
alias git='hub'

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

rmssh() {
    if [ -z "$1" ]; then
        echo "Must supply a host-name or address"
        return 1
    fi

    if [[ $1 =~ ^[0-9] ]]; then
        IP="$1"
        NAME="$(avahi-resolve-address $IP | awk '{print $2}')"
    else
        NAME="$1"
        IP="$(avahi-resolve-host-name $NAME | awk '{print $2}')"
    fi

    echo "Removing $NAME ($IP)"

    if [ ! -z "$NAME" ]; then
        ssh-keygen -R "$NAME"
    fi

    if [ ! -z "$IP" ]; then
        ssh-keygen -R "$IP"
    fi
}

pr() {
    if [ -z "$1" ]; then
        echo "Must supply a printer name"
        return 1
    fi

    ssh root@"$1".local
}

prupd() {
    if [ -z "$1" ]; then
        echo "Must supply a printer name or IP"
        return 1;
    fi

    rmssh "$1" &> /dev/null
    scp "tmp/deploy/images/bessemer-mb-p4/update.fw.tar.gz" "root@$1:/data/"
    rmssh "$1" &> /dev/null
}

