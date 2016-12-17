" Use Powerline fonts.
let g:airline_powerline_fonts=1

" Set the Airline theme to Quantum.
let g:airline_theme="quantum"

" Disable the pointy separators.
let g:airline_right_sep=""
let g:airline_left_sep=""

" Speed up switching between Vim modes.
set ttimeoutlen=10

" Always show the airline.
set laststatus=2

" Customize the right section of the statusline.
" * %l: Current line number.
" * %L: Total number of lines.
" * %v: Current column.
let g:airline_section_z = airline#section#create('%l/%L:%v')

" Define the extensions to use.
" * branch: Display the current Git branch using `vim-fugitive`.
let g:airline_extensions = ['branch']
