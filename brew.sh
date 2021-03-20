#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen

# Install other useful binaries.
brew install ack
brew install aspell
brew install cloc
brew install dark-mode
brew install epubcheck
brew install ffmpeg
brew install fswatch
brew install git
brew install git-lfs
brew install gnupg
brew install gs
brew install hyperfine
brew install imagemagick
brew install pandoc
brew install rename
brew install ssh-copy-id
brew install tree
brew install wget
brew install youtube-dl
brew install yq

# Install programming languages.
brew install gcc
brew install haskell-stack
brew install node
brew install opam
brew install python
brew install ruby
brew install texlab
brew install z3

# Install rustup and ghcup.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Remove outdated versions from the cellar.
brew cleanup
