#!/usr/bin/env bash

# Test if Homebrew is not installed.
if test ! $(which brew); then
    info "Installing Homebrew..."

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null || true

    success "Finished installing Homebrew."
fi

info "Installing Homebrew packages..."

brew tap homebrew/bundle
brew bundle

success "Finished installing Homebrew packages."
