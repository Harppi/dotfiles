# Path to your oh-my-zsh installation.
export ZSH=/Users/$(whoami)/.oh-my-zsh

# Theme
ZSH_THEME="honukai"

# Plugins
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias l="colorls --group-directories-first --almost-all"
alias ll="colorls --group-directories-first --almost-all --long"
alias ls="colorls --group-directories-first"
alias tree="colorls --tree"

alias setup-mac-os="cd ~/Documents/dotfiles && ./setup-mac-os.sh"
alias update-mac-os="cd ~/Documents/dotfiles && ./update-mac-os.sh"

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Set system locale
export LC_ALL=en_US.UTF-8

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
