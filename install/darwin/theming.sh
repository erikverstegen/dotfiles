#!/usr/bin/env bash

# Install custom fonts.
if [[ ! "$(ls ~/Library/Fonts | grep 'Roboto Mono Nerd Font Complete.ttf')" ]]; then
    info "Installing Roboto Mono font..."

    curl -fsLo "${HOME}/Library/Fonts/Roboto Mono Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/RobotoMono/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf

    success "Finished installing Roboto Mono font."
fi

# Test if the current Terminal theme is not Base16 Ocean Dark.
if [[ "$(defaults read com.apple.Terminal "Default Window Settings")" != "base16-ocean-dark" ]]; then
    # Change the Terminal theme to Base16 Ocean Dark.
    #
    # Credit: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
    osascript <<EOD

tell application "Terminal"

    local initialOpenedWindows
    local allOpenedWindows
    local windowId

    set themeName to "base16-ocean-dark"

    (* Store the IDs of all the open Terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list of available
       Terminal themes (note: this will open two additional Terminal
       windows). *)
    do shell script "open '$HOME/.dotfiles/.config/" & themeName & ".terminal'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Set the custom theme as the default Terminal theme. *)
    set default settings to settings set themeName

    (* Get the IDs of all the currently opened Terminal windows. *)
    set allOpenedWindows to id of every window

    repeat with windowId in allOpenedWindows

        (* Close the additional windows that were opened in order to add the
           custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowId then
            close (every window whose id is windowId)

        (* Change the theme for the initial opened Terminal windows to remove
           the need to close them in order for the custom theme to be
           applied. *)
        else
            set current settings of tabs of (every window whose id is windowId) to settings set themeName
        end if

    end repeat

end tell

EOD

fi
