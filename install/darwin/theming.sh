#!/usr/bin/env bash

# Install custom fonts.
if [[ ! "$(ls ~/Library/Fonts | grep 'Roboto Mono for Powerline.ttf')" ]]; then
    info "Installing Roboto Mono font..."

    curl -fsLo "${HOME}/Library/Fonts/Roboto Mono for Powerline.ttf" https://raw.githubusercontent.com/powerline/fonts/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf

    success "Finished installing Roboto Mono font."
fi

# Import the iTerm2 settings.
info "Changing the iTerm2 settings..."

defaults import com.googlecode.iterm2 "${HOME}/.dotfiles/iterm2/com.googlecode.iterm2.plist"

success "Finished changing the iTerm2 settings."
