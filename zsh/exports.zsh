# Set common applications.
export EDITOR="vim"

# Enable colors on the macOS terminal.
export CLICOLOR=1

# Set the PATH variable.
export PATH=/usr/local/bin:$PATH

if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

export PATH=$DOTFILES/bin:$PATH

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# Set Go settings.
export GOPATH=$HOME/Development/go
export PATH=/usr/local/go/bin:$PATH
