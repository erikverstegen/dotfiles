# Change the status line length.
set -g status-right-length 150
set -g status-left-length 32

# Redraw the status line every second.
set -g status-interval 1

# Theme for the status line.
set -g status-bg default
set -g status-fg colour255

set -g status-left "#[fg=colour117,bold]♟ #S #(~/.dotfiles/tmux/segments/test.sh)"
set -g status-right "#(bash ~/.dotfiles/tmux/segments/current_song.sh) #[fg=colour255,nobold]#(bash ~/.dotfiles/tmux/segments/weather.sh) %r %d %b %Y #[fg=colour117,bold]#(whoami)"

# Theme for the window tabs.
set -g window-status-format "#[fg=colour246]#I #W"
set -g window-status-current-format "#[fg=colour255,bold]#I #W"
