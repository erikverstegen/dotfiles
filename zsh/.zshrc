export DOTFILES="${HOME}/.dotfiles"
export ZSH="${DOTFILES}/zsh"

# Load all the *.zsh files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done

if [ -f "${HOME}/.localrc" ]; then
    source "${HOME}/.localrc"
fi
