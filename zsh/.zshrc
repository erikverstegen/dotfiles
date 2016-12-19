export DOTFILES="${HOME}/.dotfiles"
export ZSH="${DOTFILES}/zsh"

# Load all the *.zsh files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done

# Load the local exports.
if [ -f "${HOME}/.localrc" ]; then
    source "${HOME}/.localrc"
fi

# Load the Base16 profile helper.
BASE16_SHELL="${DOTFILES}/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "${BASE16_SHELL}/profile_helper.sh" ] && eval "$($BASE16_SHELL/profile_helper.sh)"
