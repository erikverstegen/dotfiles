#!/usr/bin/env bash

# Copy the typefaces to the "Fonts" folder.
info "Copying typefaces..."

if ! test -n "$(find ~/Library/Fonts -name 'SF Mono*.otf')"; then
    for file in $(find /Applications/Utilities/Terminal.app/Contents/Resources/Fonts -name 'SFMono*.otf'); do
        cp $file ~/Library/Fonts
    done
fi

# Import the iTerm2 settings.
info "Importing the iTerm2 settings..."
defaults import com.googlecode.iterm2 "${HOME}/.dotfiles/iterm2/com.googlecode.iterm2.plist"
