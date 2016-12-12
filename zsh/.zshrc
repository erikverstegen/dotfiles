export DOTFILES="${HOME}/.dotfiles"
export ZSH="${DOTFILES}/zsh"

# Load all the *.zsh files in the dotfiles directory.
for file ($ZSH/**/*.zsh); do
    source $file
done

# Change the colors to Base16.
source "$DOTFILES/.config/base16-shell/scripts/base16-ocean.sh"
