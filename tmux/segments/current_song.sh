#!/usr/bin/env bash

# Credit: https://www.tylerewing.co/tmux-now-playing

osascript <<EOD
set spotify_state to false
set itunes_state to false

(* Test if Spotify is running. *)
if is_app_running("Spotify") then
    tell application "Spotify" to set spotify_state to (player state as text)
end if

(* Test if iTunes is running. *)
if is_app_running("iTunes") then
    tell application "iTunes" to set itunes_state to (player state as text)
end if

(* Test if Spotify is playing a song. *)
if spotify_state is equal to "playing" then
    tell application "Spotify"
        set artist_name to artist of current track
        set track_name to name of current track

        return "#[fg=colour246]♫ " & track_name & " - #[bold]" & artist_name
    end tell

(* Test if iTunes is playing a song. *)
else if itunes_state is equal to "playing" then
    tell application "iTunes"
        set artist_name to artist of current track
        set track_name to name of current track

        return "#[fg=colour246]♫ " & track_name & " - #[bold]" & artist_name
    end tell
end if

(* Test if an app is running. *)
on is_app_running(app_name)
    tell application "System Events" to (name of processes) contains app_name
end is_app_running
EOD
