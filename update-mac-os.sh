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
  brew update; brew upgrade; brew prune; brew cleanup; brew doctor;
  pip3 install --upgrade pip setuptools wheel
}

main "@"
