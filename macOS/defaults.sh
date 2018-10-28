#!/bin/bash

main() {
  configure_finder
  configure_dock
  configure_system
  # to ensure the focus gets back to the terminal after the execution completes
  move_focus_back_to_iterm2
}

function configure_system() {
  # Disable Gatekeeper entierly to get rid of \
  # "Are you sure you want to open this application" dialog
  sudo spctl --master-disable
}

function configure_dock() {
  quit "Dock"
  # Set the icon size of Dock items to 32 pixels
  defaults write com.apple.dock tilesize -int 32
  # Don't animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false
  # Disable Dashboard
  defaults write com.apple.dashboard mcx-disabled -bool true
  # Don't show Dashboard as a Space
  defaults write com.apple.dock dashboard-in-overlay -bool true
  # Automatically hide and show the Dock
  defaults write com.apple autohide -bool true
  # Reduce the auto-hiding Dock delay
  defaults write com.apple.dock autohide-delay -float 0.01
}

function configure_finder() {
  # Require password immediately after sleep or screen saver begins
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  # Disable window animations and Get Info animations
  defaults write com.apple.finder DisableAllAnimations -bool true
  # When performing a search, serach the current folder by default
  defaults write com.apple.finder _FXDefaultSearchScope -string "SCcf"
  # Use list view in all Finder windows by default
  # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
}

function quit() {
  app=$1
  killall "$app" > /dev/null 2>&1
}

function open() {
  app=$1
  osascript << EOM
tell application "$app" to activate
EOM
}

function import_plist() {
  domain=$1
  filename=$2
  defaults delete "$domain" &> /dev/null
  defaults import "$domain" "$filename"
}

function move_focus_back_to_iterm2() {
  osascript << EOM
tell application "System Events" to tell process "iTerm2"
set frontmost to true
end tell
EOM
}

main "$@"
