" Initialize the plugins.
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

" Theming
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

" Load all the configuration files.
for file in split(glob('~/.dotfiles/vim/config/*.vim'), '\n')
    exec 'source' file
endfor
