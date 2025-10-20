#!/bin/bash

if [ ! -d "$HOME/quicklisp" ]; then
    echo "Installing Quicklisp..."

    # Download quicklisp installer
    curl -O https://beta.quicklisp.org/quicklisp.lisp

    # Install quicklisp
    sbcl --load quicklisp.lisp \
         --eval '(quicklisp-quickstart:install)' \
         --eval '(ql:add-to-init-file)' \
         --quit

    # Clean up installer
    rm quicklisp.lisp

    echo "✓ Quicklisp installed successfully"
else
    echo "Quicklisp already installed, skipping..."
fi
