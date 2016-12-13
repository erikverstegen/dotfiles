# Use `Ctrl + a` as the default command prefix.
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Reload configuration.
bind r source-file ~/.tmux.conf
