# Get the week number.
alias week="date +%V"

# IP addresses.
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Recursively find and delete all `.DS_Store` files in a directory.
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Reload Zsh configuration.
alias reload="source ${HOME}/.zshrc"
