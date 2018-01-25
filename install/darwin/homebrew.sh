#!/usr/bin/env bash

# Test if Homebrew is not installed.
if test ! $(which brew); then
    info "Installing Homebrew..."

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null || true
fi

info "Installing Homebrew packages..."
