# Set common applications.
export EDITOR="nvim"

# Enable colors on the macOS terminal.
export CLICOLOR=1

# Set the colors for the `ls` command.
export LSCOLORS=ExFxBxDxCxegedabagacad

# Set the PATH variable.
PATHS=(
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
)

export PATH="${(j.:.)PATHS}"
