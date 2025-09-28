#!/usr/bin/env bash

DOTFILES_URL="https://github.com/MasonWilie/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"

link_files() {
	pushd $HOME
	
	ln -sf ${DOTFILES_DIR}/emacs/emacs .emacs

	popd
}

main() {
	if [ -d "$DOTFILES_DIR" ]; then
		rm -rf $DOTFILES_DIR
	fi

	git clone $DOTFILES_URL $DOTFILES_DIR

	link_files
}

main

