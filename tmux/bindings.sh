# Use `Ctrl + a` as the default command prefix.
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Reload configuration.
bind r source-file ~/.tmux.conf

# Easier window splitting.
bind | split-window -h
bind - split-window -v

# Move around panes with `hjkl`.
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes with `hjkl`.
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
