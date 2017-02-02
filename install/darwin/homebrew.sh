#!/usr/bin/env bash

# Test if Homebrew is not installed.
if test ! $(which brew); then
    info "Installing Homebrew..."

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null || true

    success "Finished installing Homebrew."
fi

info "Installing Homebrew packages..."

brew tap caskroom/cask &>/dev/null

brew install ack &>/dev/null
brew install tree &>/dev/null
brew install wget &>/dev/null

brew install mas &>/dev/null
brew install git &>/dev/null
brew install zsh &>/dev/null
brew install tmux &>/dev/null
brew install reattach-to-user-namespace &>/dev/null
brew install vim --with-override-system-vi &>/dev/null

brew cask install iterm2 &>/dev/null
brew cask install spotify &>/dev/null
brew cask install telegram &>/dev/null
brew cask install google-chrome &>/dev/null
brew cask install firefox &>/dev/null
brew cask install opera &>/dev/null
brew cask install 1password &>/dev/null
brew cask install dropbox &>/dev/null
brew cask install sketch &>/dev/null
brew cask install paw &>/dev/null
brew cask install transmit &>/dev/null
brew cask install mamp &>/dev/null
brew cask install sequel-pro &>/dev/null

mas install 497799835 &>/dev/null
mas install 557168941 &>/dev/null

brew remove mas &>/dev/null

success "Finished installing Homebrew packages."
