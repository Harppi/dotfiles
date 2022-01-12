# Path to Oh My Zsh installation
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

alias setup-mac-os="cd ~/Documents/dotfiles_playbook &&
  ./prepare.sh install_dotfiles_role &&
  ansible-playbook ~/Documents/dotfiles_playbook/setup.yml &&
  cd"
alias update-mac-os="cd ~/Documents/dotfiles/files/scripts &&
  ./update-mac-os.sh"

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Set system locale
export LC_ALL=en_US.UTF-8

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load bash completions
autoload -U +X bashcompinit && bashcompinit

# Set Terraform completion rules
complete -o nospace -C /usr/local/bin/terraform terraform
