#!/usr/bin/env bash

# Inspired by: https://www.tylerewing.co/tmux-now-playing

osascript <<APPLESCRIPT
(* Test if iTunes is running. *)
if is_app_running("iTunes") then
    tell application "iTunes"
        if (player state as text) is equal to "playing" then
            if current stream title is not equal to missing value then
                set song_information to my extract_song_information(get current stream title)

                if item 1 of song_information starts with "NPO Radio" or length of song_information is equal to 1 then
                    return
                end if

                set artist_name to item 1 of song_information
                set track_name to item 2 of song_information

                return "#[fg=colour246]♫ " & artist_name & " - #[bold]" & track_name
            else
                set artist_name to artist of current track
                set track_name to name of current track

                return "#[fg=colour246]♫ " & artist_name & " - #[bold]" & track_name
            end if
        end if
    end tell
end if

(* Test if Spotify is running. *)
if is_app_running("Spotify") then
    tell application "Spotify"
        if (player state as text) is equal to "playing" then
            set artist_name to artist of current track
            set track_name to name of current track

            return "#[fg=colour246]♫ " & track_name & " - #[bold]" & artist_name
        end if
    end tell
end if

(* Test if an app is running. *)
on is_app_running(app_name)
    tell application "System Events" to (name of processes) contains app_name
end is_app_running

(* Extract song information from radio streams. *)
on extract_song_information(current_song)
    set AppleScript's text item delimiters to " - "
    set song_information to current_song's text items
    set AppleScript's text item delimiters to {""}

    return song_information
end extract_song_information
APPLESCRIPT
