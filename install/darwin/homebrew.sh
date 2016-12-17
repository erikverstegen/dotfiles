#!/usr/bin/env bash

install() {
    # Test if the requested package is not installed.
    if ! brew ls --versions "${1}" > /dev/null; then
        info "Installing \"${1}\"..."

        brew install "${1}"

        success "Finished installing \"${1}\"."
    fi
}

# Test if Homebrew is not installed.
if test ! $(which brew); then
    info "Installing Homebrew..."

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null || true

    success "Finished installing Homebrew."
fi

info "Installing Homebrew packages..."

install ack
install tree
install wget

install git
install zsh
install tmux
install reattach-to-user-namespace
install vim --with-override-system-vi

success "Finished installing Homebrew packages."
