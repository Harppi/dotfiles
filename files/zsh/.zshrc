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
alias setup-mac-os="cd ~/Documents/dotfiles_playbook &&
  ./prepare.sh install_dotfiles_role &&
  ansible-playbook ~/Documents/dotfiles_playbook/setup.yml &&
  cd"
alias update-mac-os="cd ~/Documents/dotfiles/files/scripts &&
  ./update-mac-os.sh"

# Set system locale
export LC_ALL=en_US.UTF-8

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Krew binary
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Go binary
export PATH="$PATH:$HOME/go/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load bash completions
autoload -U +X bashcompinit && bashcompinit

# Set Terraform completion rules
complete -o nospace -C /opt/homebrew/bin/terraform terraform
