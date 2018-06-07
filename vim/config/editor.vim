" Display the default mode indicator, which is made redundant by the Lightline.
set noshowmode

" Turn on syntax highlighting.
syntax on

" Turn on line numbers.
set number

" Highlight the current selected line.
set cursorline

" The amount of lines around the cursor when scrolling.
set sidescrolloff=3
set scrolloff=3

" Highlight a column to indicate the maximum width of text.
set colorcolumn=81
set textwidth=80

" Turn on invisible characters.
set list

" Set the invisible characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·

" Configure ignored files and directories.
set wildignore=.git,vendor,node_modules,bower_components,.DS_Store

" Turn off line wrapping.
set wrapmargin=0
set textwidth=0
set nowrap

" Use soft tabs instead of hard tabs
set softtabstop=4
set shiftwidth=4
set expandtab
set tabstop=4

" Remove the delay when switching between modes.
set ttimeoutlen=50
