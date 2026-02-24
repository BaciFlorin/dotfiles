#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install stow if not available
if ! command -v stow &> /dev/null; then
    echo "Installing GNU Stow..."
    brew install stow
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm -f "$HOME/.zshrc"  # Remove the default .zshrc Oh My Zsh creates
fi

# Point zsh to config in ~/.config/zshrc
echo "Setting up ~/.zshenv..."
cat > "$HOME/.zshenv" << 'EOF'
export ZDOTDIR="$HOME/.config/zshrc"
EOF

# Stow dotfiles
echo "Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow .

echo "Done! Open a new terminal tab to apply changes."
