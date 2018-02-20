" Initialize the plugins.
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'yggdroot/indentline'

Plug 'robinfehr/nerdtree-git-plugin' " Fork of Xuyuanp/nerdtree-git-plugin with
                                     " node coloring of files and directories.
Plug 'airblade/vim-gitgutter'

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
