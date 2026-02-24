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
    rm -f "$HOME/.zshrc"
fi

# Install tmux if not available
if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."
    brew install tmux
fi

# Enable mouse interaction in tmux
TMUX_CONF="$HOME/.tmux.conf"
if ! grep -q "set -g mouse on" "$TMUX_CONF" 2>/dev/null; then
    echo "Enabling tmux mouse support..."
    echo "set -g mouse on" >> "$TMUX_CONF"
fi

# Install CLI tools
echo "Installing CLI tools..."
brew install zoxide autojump fzf 2>/dev/null || true

# Install Oh My Zsh custom plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
plugins="
zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
zsh-completions https://github.com/zsh-users/zsh-completions
fzf-tab https://github.com/Aloxaf/fzf-tab
you-should-use https://github.com/MichaelAquilina/zsh-you-should-use
"
echo "$plugins" | while read -r name url; do
    [ -z "$name" ] && continue
    if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
        echo "Installing $name..."
        git clone "$url" "$ZSH_CUSTOM/plugins/$name"
    fi
done

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
