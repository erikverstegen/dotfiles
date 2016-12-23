#!/usr/bin/env bash

# Get the now playing data.
nowplaying_data=$(curl --max-time 4 -s "http://radiobox2.omroep.nl/data/radiobox2/nowonair/2.json?npo_cc_skip_wall=1")

# Get the artist.
# "artist":"Bob Dylan"
artist=$(echo "$nowplaying_data" | sed 's/.*"artist":"\([^"]*\)".*/\1/')

# Get the track.
# "title":"It's Alright Ma (I'm Only Bleeding)"
track=$(echo "$nowplaying_data" | sed 's/.*"title":"\([^"]*\)".*/\1/')

echo "#[fg=colour246]♫ ${track} - #[bold]${artist}"
