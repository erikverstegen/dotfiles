" Initialize the plugins.
call plug#begin('~/.vim/plugged')

" Editor
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'yggdroot/indentline'

Plug 'gregsexton/MatchTag'

" NERDTree
Plug 'robinfehr/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'

" Theming
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'

" Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

" Load all the configuration files.
for file in split(glob('~/.dotfiles/nvim/config/*.vim'), '\n')
    exec 'source' file
endfor
