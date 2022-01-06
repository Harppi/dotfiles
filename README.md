# macOS dotfiles and configuration scripts

1. [macOS dotfiles and configuration scripts](#macOS-dotfiles-and-configuration-scripts)
2. [Variables](#variables)
    1. [Ansible](#ansible)
3. [Getting started](#getting-started)
    1. [Deploy the entire configuration](#deploy-the-entire-configuration)
    2. [Install Homebrew taps, packages and casks](#install-homebrew-taps-packages-and-casks)
    3. [Configure shell](#configure-shell)
    4. [Configure Vim](#configure-vim)
    5. [Configure iTerm2](#configure-iterm2)
    6. [Install Ruby Gems](#install-ruby-gems)
    7. [Configure macOS preferences](#configure-macos-preferences)
    8. [Install Python packages](#install-python-packages)
    9. [Configure window manager](#configure-window-manager)
4. [License](#license)

The `dotfiles` Ansible role configures macOS to serve as a development
environment and adjusts the settings of the Dock and Finder applications.

## Variables

### Ansible

* `oh_my_zsh_basepath` - defines the root directory of Oh My Zsh
* `vim_basepath` - defines the root directory of Vim
* `install_oh_my_zsh` - a boolean that controls Oh My Zsh installation (default:
  `false`)

## Getting started

Clone the [dotfiles_playbook](https://github.com/Harppi/dotfiles_playbook) and
run
[prepare.sh](https://github.com/Harppi/dotfiles_playbook/blob/prepare/prepare.sh).
The script installs the prerequisites that enable running Ansible playbooks and
clones the [dotfiles](https://github.com/Harppi/dotfiles) Ansible role. After
the script finishes successfully, run any of the following commands.

### Deploy the entire configuration

This command deploys the entire configuration in the order in which
[dotfiles/tasks/main.yml](https://github.com/Harppi/dotfiles/blob/master/tasks/main.yml)
lists the task files.

```shell
ansible-playbook setup.yml
```

### Install Homebrew taps, packages and casks

This command installs third-party repositories, packages, macOS apps, fonts,
plugins and other non-open source software by using Homebrew.

```shell
ansible-playbook setup.yml -t dotfiles_brew
```

### Configure shell

This command configures the ZSH shell and installs Oh My Zsh including its
themes and plugins. Set an extra variable called `install_oh_my_zsh` to `true`
to install Oh My Zsh and to `false` to skip the installation.

```shell
ansible-playbook setup.yml -t dotfiles_zsh
```

### Configure Vim

This command configures Vim and installs its plugins and color themes.

```shell
ansible-playbook setup.yml -t dotfiles_vim
```

### Configure iTerm2

This command configures iTerm2 preferences.

```shell
ansible-playbook setup.yml -t dotfiles_iterm2
```

### Install Ruby Gems

This command installs Ruby Gems by using `Bundler`.

```shell
ansible-playbook setup.yml -t dotfiles_bundle
```

### Configure macOS preferences

This command configures the Dock and Finder applications.

```shell
ansible-playbook setup.yml -t dotfiles_macos
```

### Install Python packages

This command installs Python packages by using `pip3`.

### Configure Git

This command moves the `.gitconfig` and `.gitignore` files to the home directory
of the user that runs the command.

```shell
ansible-playbook setup.yml -t dotfiles_git
```

### Configure window manager

This command configures `yabai` window manager and `skhd` hotkey daemon.

```shell
ansible-playbook setup.yml -t dotfiles_window_manager
```

## License

GPLv3

    dotfiles - Setup macOS configuration
    Copyright (C) 2022 Harppi

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the Free
    Software Foundation, either version 3 of the License, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
    more details.

    You should have received a copy of the GNU General Public License along with
    this program.  If not, see <http://www.gnu.org/licenses/>.
