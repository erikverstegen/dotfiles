#!/usr/bin/bash env

# Background credit: https://www.flickr.com/photos/thomashawk/5124298941
# Licensed under the terms of CC BY-NC 2.0.

if [[ ! -f "${HOME}/Pictures/Background.jpg" ]]; then
    info "Changing the background picture..."

    # Download the background.
    curl -fsLo "${HOME}/Pictures/Background.jpg" https://farm2.staticflickr.com/1201/5124298941_6960dd7102_o_d.jpg
    chflags hidden "${HOME}/Pictures/Background.jpg"

    # Set the background.
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${HOME}/Pictures/Background.jpg'"

    success "Finished changing the background picture."
fi
