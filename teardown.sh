#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Unstow dotfiles
echo "Unstowing dotfiles..."
cd "$DOTFILES_DIR"
stow -D .

# Remove zshenv
if [ -f "$HOME/.zshenv" ]; then
    echo "Removing ~/.zshenv..."
    rm "$HOME/.zshenv"
fi

echo "Done! Dotfiles unlinked."
