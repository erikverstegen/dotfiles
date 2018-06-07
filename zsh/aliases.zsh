# Clear terminal scroll-back.
alias cls="clear && printf '\e[3J'"

# Gets the IP addresses.
alias ip="printf 'Public IP: '; dig +short myip.opendns.com @resolver1.opendns.com; printf 'Local IP: '; ipconfig getifaddr en0"

# Recursively find and delete all the `.DS_Store` files in a directory.
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Reload the Zsh configuration.
alias reload="source ${HOME}/.zshrc"

# Remove unwanted folders and files (such as .git, node_modules) from the `tree`
# command output.
alias tree="tree -aC -I '.git|node_modules|vendor|var|.DS_Store' --dirsfirst"
