# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    brew
    macos
    history
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    fzf-tab
    you-should-use
    autojump
)

source $ZSH/oh-my-zsh.sh

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# AeroSpace fuzzy window finder
ff() {
    aerospace list-windows --all | fzf --bind "enter:execute-silent(aerospace focus --window-id {1})+abort"
}

# Git aliases
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gp='git push origin HEAD'
alias gpu='git pull origin'
alias gst='git status'
alias glog='git log --graph --topo-order --pretty="%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N" --abbrev-commit'
alias gdiff='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'
