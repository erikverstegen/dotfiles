# Enable 24-bit colors.
set-option -ga terminal-overrides ",xterm-256color:Tc"

# Change the status line length.
set -g status-right-length 150
set -g status-left-length 32

# Redraw the status line every second.
set -g status-interval 1

# Theme for the status line.
set -g status-bg default
set -g status-fg colour251

set -g status-left "#[fg=colour004,bold]#S "
set -g status-right "#[fg=colour246]#(bash ~/.dotfiles/tmux/segments/current_song.sh) #[fg=colour251,nobold]#(bash ~/.dotfiles/tmux/segments/git.sh)#[fg=colour251,nobold]%I:%M %p #[fg=colour004,bold]#(whoami)"

# Theme for the window tabs.
set -g window-status-format "#[fg=colour246]#I #W"
set -g window-status-current-format "#[fg=colour251,bold]#I #W"

# Theme for the pane borders.
set -g pane-border-style fg=colour246
set -g pane-active-border-style fg=colour004
