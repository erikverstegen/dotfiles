" Turn on syntax highlighting.
syntax on

" Show line numbers.
set number

" Highlight the current selected line.
set cursorline

" Turn off line wrapping.
set nowrap

" Prevent line wrapping while typing.
set formatoptions-=t

" Set custom invisible characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·

" Display invisible characters.
set list

" Turn off swap files.
set noswapfile

" Use 4 spaces instead of tabs.
set softtabstop=4
set shiftwidth=4
set expandtab
set tabstop=4

" Set the maximum width of text to 80 characters.
set textwidth=80

" Highlight a column to indicate the maximum width of text.
set colorcolumn=+1

" Only redraw the screen when needed.
set lazyredraw

" Tell Vim we're using a fast terminal connection.
set ttyfast

" Automatically detect when a file is changed from outside.
set autoread

" Make backspace behave normally.
set backspace=indent,eol,start

" Be smart with indenting.
set smartindent
set autoindent

" Highlight matching brackets.
set showmatch

" Hide the Vim mode in the command bar.
set noshowmode
