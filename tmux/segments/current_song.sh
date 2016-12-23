#!/usr/bin/env bash

# Inspired by: https://www.tylerewing.co/tmux-now-playing

osascript <<APPLESCRIPT
(* Test if Safari is running. *)
if is_app_running("Safari") then
    tell application "Safari"
        (* Get all the open URLs. *)
        set urls to get URL of every tab of every window

        (* Loop through all the open URLs. *)
        repeat with currentWindow in urls
            repeat with currentUrl in currentWindow
                (* Test if we are listening to Radio 2. *)
                if (currentUrl as string) is equal to "http://radioplayer.npo.nl/radio2/" then
                    return do shell script "~/.dotfiles/tmux/segments/radio2.sh"
                end if
            end repeat
        end repeat
    end tell
end if

(* Test if iTunes is running. *)
if is_app_running("iTunes") then
    tell application "iTunes"
        if (player state as text) is equal to "playing" then
            set artist_name to artist of current track
            set track_name to name of current track

            return "#[fg=colour246]♫ " & track_name & " - #[bold]" & artist_name
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
APPLESCRIPT
