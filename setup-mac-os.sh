#!/bin/bash

main() {
  # Ask for sudo credentials
  ask_for_sudo_credentials
  # Install Homebrew
  install_homebrew
  # Clone Dotfiles repository
  clone_dotfiles_repository
  # Install all packages in Dotfiles repository's Brewfile
  install_packages_with_brewfile
  # Change default shell to zsh
  change_shell
  # Install Oh My ZSH
  install_oh_my_zsh
  # Setup symlinks for vim, git and chunkwm
  setup_symlinks
  # Setup Vim
  setup_vim
  # Configure iTerm2
  configure_iterm2
  # Install gems
  bundle_install
  # Configure gems
  configure_gems
  # Setup macOS defaults
  setup_macOS_defaults
}

DOTFILES_REPO=~/Documents/dotfiles

function ask_for_sudo_credentials() {
  info "Prompting for sudo password..."
  if sudo --validate; then
    # Keep-alive
    while true; do sudo --non-interactive true; \
      sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "Sudo credentials updated."
  fi
}

function install_homebrew() {
  info "Installing Homebrew..."
  if hash brew 2>/dev/null; then
    success "Homebrew already exists."
  else
    url=https://raw.githubusercontent.com/Homebrew/install/master/install
    if /usr/bin/ruby -e "$/(curl -fsSL ${url})"; then
      success "Homebrew installation succeeded."
    else
      error "Homebrew installation failed."
      exit 1
    fi
  fi
}

function brew_install() {
  package_to_install="$1"
  info "brew install ${package_to_install}"
  if hash "$package_to_install" 2>/dev/null; then
    success "${package_to_install} already exists."
  else
    if brew install "$package_to_install"; then
      success "Package ${package_to_install} installation succeeded."
    else
      error "Package ${package_to_install} installation failed."
      exit 1
    fi
  fi
}

function clone_dotfiles_repository() {
  info "Cloning Dotfiles repository into ${DOTFILES_REPO}..."
  if test -e $DOTFILES_REPO; then
    substep "${DOTFILES_REPO} already exists."
    pull_latest $DOTFILES_REPO
  else
    url=https://github.com/Harppi/dotfiles.git
    if git clone "$url" ${DOTFILES_REPO}; then
      success "Cloned info info ${DOTFILES_REPO}"
    else
      error "Cloning into ${DOTFILES_REPO} failed."
      exit 1
    fi
  fi
}

function pull_latest() {
  info "Pulling latest changes in ${1} repository..."
  if git -C $1 pull origin master &> /dev/null; then
    success "Pull successful in ${1} repository."
  else
    error "Please pull the lastest changes in ${1} repository manually."
  fi
}

function install_packages_with_brewfile() {
  info "Installing packages within ${DOTFILES_REPO}/brew/Brewfile..."
  if brew bundle --file=$DOTFILES_REPO/brew/Brewfile; then
    success "Brewfile installation succeeded."
  else
    error "Brewfile installation failed."
    continue
  fi
}

function change_shell() {
  info "ZSH shell setup..."
  if grep --quiet zsh <<< "$SHELL"; then
    success "ZSH shell already exists."
  else
    user=$(whoami)
    substep "Switching shell to ZSH for \"${user}\""
    if sudo chsh -s /bin/zsh; then
      success "ZSH shell successfully set for \"${user}\""
    else
      error "Please try setting the ZSH shell again."
    fi
  fi
}

function install_oh_my_zsh() {
  info "Oh my ZSH setup..."
  substep "Installing Oh My ZSH"
  url=https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  if sh -c "$(curl -fsSL ${url})"; then
    success "Oh My ZSH installation succeeded."
  else
    error "Oh My ZSH installation failed."
    exit 1
  fi
  substep "Installing Oh My ZSH themes"
  url="https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/\
    master/honukai.zsh-theme"
  url=$(tr -d ' ' <<< "$url")
  if curl -fsSL ${url} > ~/.oh-my-zsh/custom/themes/honukai.zsh-theme; then
    success "Oh My ZSH themes installation succeeded."
  else
    error "Oh My ZSH themes installation failed."
    exit 1
  fi
  substep "Installing Oh My ZSH plugins"
  url=https://github.com/zsh-users/zsh-syntax-highlighting
  if git clone "$url" ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then
    success "Oh My ZSH plugins installation succeeded."
  else
    error "Oh My ZSH plugins installation failed."
    exit 1
  fi
}

function setup_symlinks() {
  info "Setting up symlinks..."
  symlink "vim" ${DOTFILES_REPO}/vim/.vimrc ~/.vimrc
  symlink "gitconfig" ${DOTFILES_REPO}/.gitconfig ~/.gitconfig
  symlink "gitignore" ${DOTFILES_REPO}/.gitignore_global ~/.gitignore_global
  symlink "zshrc" ${DOTFILES_REPO}/.zshrc ~/.zshrc
  symlink "chunkwm" ${DOTFILES_REPO}/macOS/.chunkwmrc_work ~/.chunkwmrc
  symlink "skhd" ${DOTFILES_REPO}/macOS/.skhdrc ~/.skhdrc
  success "Symlinks successfully setup."
}

function change_chunkwmrc() {
  info "Changing .chunkwmrc symlink..."
  symlink "chunkwm" ${DOTFILES_REPO}/macOS/${CHUNKWMRC} ~/.chunkwmrc
}

function symlink() {
  application=$1
  point_to=$2
  destination=$3
  destination_dir=$(dirname "$destination")

  if test ! -e "$destination_dir"; then
    substep "Creating ${destination_dir}"
    mkdir -p "$destination_dir"
  fi
  if rm -rf "$destination" && ln -s "$point_to" "$destination"; then
    success "Symlinking ${application} done."
  else
    error "Symlinking ${application} failed."
    exit 1
  fi
}

function setup_vim() {
  info "Setting up vim..."
  substep "Installing Pathogen"
  if test -e ~/.vim/autoload/pathogen.vim; then
    substep "Pathogen already exists"
    pull_latest ~/.vim/autoload/pathogen.vim
  else
    if mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim; then
      substep "Pathogen installation succeeded."
    else
      error "Pathogen installation failed."
      exit 1
    fi
  fi
  substep "Installing all plugins"
  if vim/clone_plugins; then
    substep "Plugin installation succeeded."
  elif
    for dir in ~/.vim/bundle/*;
    do
      pull_latest "$dir";
    done; then
    substep "Plugins updated."
  else
    error "Plugin installation failed."
    exit 1
  fi
  substep "Setting up color themes."
  if vim/clone_colorthemes; then
    substep "Setting up color themes succeeded."
  elif
    for dir in ~/.vim/colors/*;
    do
      pull_latest "$dir";
    done; then
    substep "Color themes updated."
  else
    error "Setting up color theme failed."
    exit 1
  fi
}

function configure_iterm2() {
  info "Configuring iTerm2..."
  if \
    defaults write com.googlecode.iterm2 \
      LoadPrefsFromCustomFolder -int 1 && \
    defaults write com.googlecode.iterm2 \
      PrefsCustomFolder -string "${DOTFILES_REPO}/iTerm2";
  then
    success "iTerm2 configuration succeeded."
  else
    error "iTerm2 configuration failed."
    exit 1
  fi
  substep "Opening iTerm2"
  if osascript -e 'tell application "iTerm" to activate'; then
    substep "iTerm2 activation successful"
  else
    error "Failed to activate iTerm2"
  exit 1
  fi
}

function bundle_install() {
  info "Installing gems within ${DOTFILES_REPO}/.bundle/Gemfile..."
  if bundle install --gemfile=$DOTFILES_REPO/.bundle/Gemfile; then
    success "bundle install succeeded."
  else
    error "bundle install failed."
    continue
  fi
}

function configure_gems() {
  info "Configuring gems..."
  substep "Configure colorls"
  if mkdir -p ~/.config/colorls && \
    cp ${DOTFILES_REPO}/.bundle/colorls/dark_colors.yaml \
    ~/.config/colorls/; then
    success "colorls configuration succeeded."
  else
    error "colorls configuration failed."
    continue
  fi
}

function setup_macOS_defaults() {
  info "Updating macOS defaults..."

  current_dir=$(pwd)
  cd ${DOTFILES_REPO}/macOS
  if bash defaults.sh; then
    cd $current_dir
    success "macOS defaults setup succeeded."
  else
    cd $current_Dir
    error "macOS defaults setup failed."
    exit 1
  fi
}

function pip3_install() {
  packages_to_install=("$@")

  for package_to_install in "${packages_to_install[@]}"
  do
    info "pip3 install ${package_to_install}"
    if pip3 --quiet show "$package_to_install"; then
      success "${package_to_install} already exists."
    else
      if pip3 install "$package_to_install"; then
        success "Package ${package_to_install} installation succeeded."
      else
        error "Package ${package_to_install} installation failed."
        exit 1
      fi
    fi
  done
}

function coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}

function info() {
  coloredEcho "$1" blue "========>"
}

function substep() {
  coloredEcho "$1" magenta "===="
}

function success() {
  coloredEcho "$1" green "========>"
}

function error() {
  coloredEcho "$1" red "========>"
}

case "$1" in
  change_chunkwmrc)
    CHUNKWMRC=$2
    change_chunkwmrc
    ;;
  install_homebrew)
    install_homebrew
    ;;
  clone_dotfiles_repository)
    clone_dotfiles_repository
    ;;
  install_packages_with_brewfile)
    install_packages_with_brewfile
    ;;
  change_shell)
    change_shell
    ;;
  install_oh_my_zsh)
    install_oh_my_zsh
    ;;
  setup_symlinks)
    setup_symlinks
    ;;
  setup_vim)
    setup_vim
    ;;
  configure_iterm2)
    configure_iterm2
    ;;
  bundle_install)
    bundle_install
    ;;
  configure_gems)
    configure_gems
    ;;
  setup_macOS_defaults)
    setup_macOS_defaults
    ;;
  *)
    main "$@"
esac
