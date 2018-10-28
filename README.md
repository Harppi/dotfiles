# macOS dotfiles and configuration scripts

## Initial configuration on a brand new macOS
* Enter the following one-liner, kick back and enjoy!  ``` curl --silent
  https://raw.githubusercontent.com/Harppi/dotfiles/master/setup-mac-os.sh |
  bash ```

## What does it do?
* Configures a software development environment without a hassle:
  * Installs Homebrew
  * Installs a bunch of useful applications by using Homebrew and pip
  * Installs and configures iTerm2
  * Installs [chunkwm](https://koekeishiya.github.io/chunkwm/) and
    [skhd](https://github.com/koekeishiya/skhd)
  * Sets ZSH as the default shell
  * Configures Git (remember to update your user information 😉)
  * Configures Vim including plugins and color schemes
  * Configures macOS defaults such as Dock, Finder and Gatekeeper

* Updates changes in any of the above
  * The configuration script `setup\_mac\_os.sh` can be run periodically
    whenever the dotfiles repository is modified
  * The update script `update\_mac\_os.sh` installs software updates from the
    App store and updates all packages maintained by Homebrew and pip

The configuration scripts are based on [a blog post by Sajjad
Hosseini](https://www.futurice.com/blog/build-a-macos-empire/) and his [dotfiles
repository](https://github.com/Sajjadhosn/dotfiles).

