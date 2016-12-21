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

# Change the background.
if [[ ! -f "${HOME}/Pictures/Background.jpg" ]]; then
    info "Changing the background picture..."

    # Download the background.
    # Background credit: https://www.flickr.com/photos/thomashawk/5124298941
    # Licensed under the terms of CC BY-NC 2.0.
    curl -fsLo "${HOME}/Pictures/Background.jpg" https://farm2.staticflickr.com/1201/5124298941_6960dd7102_o_d.jpg

    # Set the background.
    osascript -e "tell application \"Finder\" to set desktop picture to \"${HOME}/Pictures/Background.jpg\" as POSIX file"

    # Hide the background file.
    chflags hidden "${HOME}/Pictures/Background.jpg"

    success "Finished changing the background picture."
fi
