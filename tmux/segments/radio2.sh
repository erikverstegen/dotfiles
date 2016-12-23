#!/usr/bin/env bash

TOP2000_FILE="/var/tmp/top2000-$(date +%Y)"
TOP2000=false

# Download this year's Top 2000 list.
if [ ! -f $TOP2000_FILE ]; then
    curl -fsLo $TOP2000_FILE "http://www.nporadio2.nl/index.php?option=com_ajax&plugin=Top2000&format=json&year=$(date +%Y)&npo_cc_skip_wall=1"
fi

current_date=$(date +%m%d)

if [ $current_date -ge 2225 -a $current_date -le 2231  ]; then
    TOP2000=true
fi

top2000_data=$(cat $TOP2000_FILE)

# Get the now playing data.
nowplaying_data=$(curl --max-time 4 -s "http://radiobox2.omroep.nl/data/radiobox2/nowonair/2.json?npo_cc_skip_wall=1")

# Get the artist.
# "artist":"Bob Dylan"
artist=$(echo "$nowplaying_data" | sed 's/.*"artist":"\([^"]*\)".*/\1/')

# Get the track.
# "title":"It's Alright Ma (I'm Only Bleeding)"
track=$(echo "$nowplaying_data" | sed 's/.*"title":"\([^"]*\)".*/\1/')

# Get the Top 2000 position.
if $TOP2000; then
    position=$(echo "$top2000_data" | grep -Zoi "{\"s\":\"${track}\",\"a\":\"${artist}\"[^}]*}" | sed 's/.*"pos":\([^"]*\),.*/\1/')
    top2000_position=" #[fg=colour001](${position})"
fi

echo "#[fg=colour246]♫ ${track} - #[bold]${artist}${top2000_position}"

