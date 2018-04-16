" Initialize the plugins.
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'robinfehr/nerdtree-git-plugin' " Fork of Xuyuanp/nerdtree-git-plugin with
                                     " node coloring of files and directories.

" Theming
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'yggdroot/indentline'

" Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

" Load all the configuration files.
for file in split(glob('~/.dotfiles/vim/config/*.vim'), '\n')
    exec 'source' file
endfor
