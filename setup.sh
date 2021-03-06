#!/bin/sh

# This script is intended to install these various config files on the system
# on which it is run.

CURDIR="$PWD"
CONFIG_DIR="$( cd $(dirname $0) ; pwd -P )"

BASHRC_SRC="$CONFIG_DIR/bash/bash_jmf.sh"
VIMDIR_SRC="$CONFIG_DIR/vim/"
VIMRC_SRC="$CONFIG_DIR/vimrc"
GITCONFIG_SRC="$CONFIG_DIR/gitconfig"
ASTYLERC_SRC="$CONFIG_DIR/astylerc"
TMUX_SRC="$CONFIG_DIR/tmux.conf"

VIMDIR="$HOME/.vim"
VIMRC="$HOME/.vimrc"
BASHRC="$HOME/.bashrc"
ASTYLERC="$HOME/.astylerc"
GITCONFIG="$HOME/.gitconfig"
TMUX="$HOME/.tmux.conf"

case $(uname) in
	Darwin)
		echo "OS X detected"
		BASHRC="$HOME/.bash_profile"
		;;
esac

# Bash
if [ -e "$BASHRC" ]; then
	# .bashrc exists, check to see whether we already added our sourcing
	# line to it.
	grep -q "source $BASHRC_SRC" $BASHRC
	if [ $? -eq 0 ]; then
		echo "$(basename $BASHRC)\t\tAlready up to date."
	else
		echo "source $BASHRC_SRC" >> $BASHRC
		echo "$(basename $BASHRC)\t\tUpdated."
	fi
else
	# .bashrc didn't already exist.
	echo "source $BASHRC_SRC" >> $BASHRC
	echo "$(basename $BASHRC)\t\tUpdated"
fi

# Vim
if [ -e "$VIMRC" ]; then
	# Check to see whether our file has already been sourced.
	grep -q "source $VIMRC_SRC" $VIMRC
	if [ $? -eq 0 ]; then
		echo "$(basename $VIMRC)\t\tAlready up to date."
	else
		echo "source $VIMRC_SRC" >> "$VIMRC"
	fi
else
	echo "source $VIMRC_SRC" >> "$VIMRC"
fi

if [ -e "$VIMDIR" ]; then
    TMP=$(rsync -av $VIMDIR_SRC $VIMDIR)
else
    TMP=$(ln -s $VIMDIR_SRC $VIMDIR)
fi

# Git
TMP="$(git config --global --get-all include.path)"
case "$TMP" in
	*${GITCONFIG_SRC}*)
		echo "$(basename $GITCONFIG)\tAlready up to date."
		;;
	*)
		TMP=$(git config --global --add include.path $GITCONFIG_SRC)
esac

# AStyle
if [ ! -e "$ASTYLERC" ]; then
	echo "Adding symlink for $ASTYLERC"
	TMP=$(ln -s $ASTYLERC_SRC $ASTYLERC)
else
	echo "$(basename $ASTYLERC)\tAlready exists"
fi

# TMux
if [ ! -e "$TMUX" ]; then
    echo "source ${TMUX_SRC}" >> $TMUX
else
	grep -q "source $TMUX_SRC" $TMUX
	if [ $? -eq 0 ]; then
        echo "${TMUX} already up to date."
    else
        echo "source ${TMUX_SRC}" >> $TMUX
    fi
fi
