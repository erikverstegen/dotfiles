# export DOTFILES="${HOME}/.dotfiles"
export DOTFILES="${HOME}/Development/dotfiles"
export ZSH="${DOTFILES}/zsh"

# Load all the *.zsh files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done
