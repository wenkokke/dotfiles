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
brew install moreutils
brew install findutils
brew install gnu-sed
brew install gawk
# Install a modern version of Bash.
brew install bash
brew install bash-completion@2

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

# Install fonts.
brew install --cask font-dejavu-sans
brew install --cask font-fontawesome
brew install --cask font-freesans
brew install --cask font-inconsolata
brew install --cask font-mononoki
brew install --cask font-source-code-pro

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
git lfs install
git lfs install --system
brew install gnupg
brew install gs
brew install hyperfine
brew install imagemagick
brew install pandoc
brew install pinentry-mac
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
brew install rename
brew install ssh-copy-id
brew install tree
brew install wget
brew install youtube-dl
brew install yq
brew install --cask wkhtmltopdf

# Install programming languages.
brew install gcc
brew install haskell-stack
brew install node
brew install opam
brew install python
brew install ruby
brew install texlab
brew install z3
brew install --cask racket
brew install --cask mactex-no-gui
brew install --cask miniconda

# Install rustup and ghcup.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Install applications.
brew install --cask bettertouchtool
brew install --cask discord
brew install --cask disk-inventory-x
brew install --cask emacs-mac-spacemacs-icon
brew install --cask firefox
brew install --cask skim
brew install --cask krita
brew install --cask obs
brew install --cask protonmail-bridge
brew install --cask signal
brew install --cask spectacle
brew install --cask transmission
brew install --cask vlc
brew install --cask whatsapp
brew install --cask workflowy
brew install --cask zulip

# Remove outdated versions from the cellar.
brew cleanup
