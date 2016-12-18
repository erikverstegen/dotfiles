export DOTFILES="${HOME}/.dotfiles"
export ZSH="${DOTFILES}/zsh"

# Load all the *.zsh files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done

if [ -f "${HOME}/.localrc" ]; then
    source "${HOME}/.localrc"
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
