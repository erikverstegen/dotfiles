export ZSH="${HOME}/.dotfiles/zsh"

# Load all the `*.zsh` files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done

# Load the local exports from the `~/.localrc` file.
if [ -f "${HOME}/.localrc" ]; then
    source "${HOME}/.localrc"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

source /Users/erikverstegen/.docker/init-zsh.sh || true # Added by Docker Desktop
