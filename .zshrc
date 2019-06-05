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
alias rs="rsync -Pahvz"
alias lc="colorls -lA --sd"
alias l="colorls --group-directories-first --almost-all"
alias ll="colorls --group-directories-first --almost-all --long"
alias ls="colorls --group-directories-first"
alias tree="colorls --tree"

alias setup-mac-os="cd ~/Documents/dotfiles && ./setup-mac-os.sh"
alias update-mac-os="cd ~/Documents/dotfiles && ./update-mac-os.sh"
alias home-tiling="cd ~/Documents/dotfiles/ && ./setup-mac-os.sh \
  change_chunkwmrc .chunkwmrc_home && brew services reload chunkwm && cd"
alias work-tiling="cd ~/Documents/dotfiles/ && ./setup-mac-os.sh \
  change_chunkwmrc .chunkwmrc_work && brew services reload chunkwm && cd"
alias laptop-tiling="cd ~/Documents/dotfiles/ && ./setup-mac-os.sh \
  change_chunkwmrc .chunkwmrc_laptop && brew services reload chunkwm && cd"
alias desktop-tiling="cd ~/Documents/dotfiles/ && ./setup-mac-os.sh \
  change_chunkwmrc .chunkwmrc_desktop && brew services reload chunkwm && cd"

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
