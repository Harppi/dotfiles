#!/bin/bash

main() {
  # Homebrew and pip updates
  update_packages
  # All App Store updates
  update_os
}

function update_packages() {
  brew update; brew upgrade; brew prune; brew cleanup; brew doctor;
  pip3 install --upgrade pip setuptools wheel
}

function update_os() {
  sudo softwareupdate --install --all
}

main "@"
