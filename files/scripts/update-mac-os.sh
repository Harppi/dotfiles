#!/bin/bash

main() {
  # All App Store updates
  update_os
  # Homebrew and pip updates
  update_packages
}

function update_os() {
  sudo softwareupdate --install --all
}

function update_packages() {
  brew update; brew upgrade; brew cleanup; brew doctor;
}

main "@"
