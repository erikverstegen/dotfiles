# Change the status line length.
set -g status-right-length 150
set -g status-left-length 32

# Redraw the status line every 5 seconds.
set -g status-interval 5

# Theme for the status line.
set -g status-bg default
set -g status-fg colour255

set -g status-left "#[fg=colour117,bold]♟ #S #(~/.dotfiles/tmux/segments/test.sh)"
set -g status-right "#(bash ~/.dotfiles/tmux/segments/current_song.sh) #[fg=colour255,nobold]#(bash ~/.dotfiles/tmux/segments/weather.sh) %I:%M %p %d %b %Y #[fg=colour117,bold]#(whoami)"

# Theme for the window tabs.
set -g window-status-format "#[fg=colour241]#I #W"
set -g window-status-current-format "#[fg=colour255,bold]#I #W"

# Theme for the pane borders.
set -g pane-border-style fg=colour246
set -g pane-active-border-style fg=colour075
