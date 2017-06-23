#!/usr/bin/env bash

# Inspired by: https://www.tylerewing.co/tmux-now-playing
osascript <<APPLESCRIPT
tell application "System Events"
    set running_apps to (name of every process)
end tell

set app_names to {"iTunes", "Spotify"}

repeat with app_name in app_names
    (* Test if the app is running. *)
    if running_apps contains app_name then
        tell application app_name
            using terms from application "iTunes"
                if (player state as text) is equal to "playing" then
                    set artist_name to artist of current track
                    set track_name to name of current track

                    return "#[fg=colour246]♫ " & track_name & " - #[bold]" & artist_name
                end if
            end using terms from
        end tell
    end if
end repeat
APPLESCRIPT
