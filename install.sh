#!/bin/bash

set -e
sudo -v

DOTFILES_URL="https://github.com/MasonWilie/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"

link_files() {
	pushd $HOME
	
	ln -sf ${DOTFILES_DIR}/emacs/emacs .emacs
	ln -sf ${DOTFILES_DIR}/lisp/sbclrc .sbclrc

	popd
}

run_setups() {
    local DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
    
    echo "Searching for setup.sh files in $DOTFILES_DIR..."
    
    find "$DOTFILES_DIR" -type f -name "setup.sh" | while read -r setup_script; do
        echo "--------------------------------------"
        echo "Running: $setup_script"
        
        local script_dir=$(dirname "$setup_script")
        chmod +x "$setup_script"
        
        (cd "$script_dir" && bash "$setup_script")
        
        if [ $? -eq 0 ]; then
            echo "✓ Success"
        else
            echo "✗ Failed"
            return 1
        fi
    done
    
    echo "--------------------------------------"
    echo "All setup scripts completed!"
}

main() {
	if [ -d "$DOTFILES_DIR" ]; then
		rm -rf $DOTFILES_DIR
	fi

	git clone $DOTFILES_URL $DOTFILES_DIR

	apt-get install update

	link_files
	run_setups
}

main

