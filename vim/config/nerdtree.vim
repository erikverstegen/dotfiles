" Open the NERDTree automatically when Vim starts up opening a directory.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close Vim when the NERDTree is the only window left.
autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" Disable the invisible characters in the NERDTree.
autocmd FileType nerdtree setlocal nolist

" Toggle the NERDTree with `ctrl + n`.
map <silent> <C-n> :NERDTreeToggle<CR>

" Enable node colorization, and disable flags for the Git support.
let g:NERDTreeGitStatusNodeColorization=1
let g:NERDTreeGitStatusWithFlags=0

" Hide the cursor line.
let g:NERDTreeHighlightCursorline=0

" Hide the files and folders specified in wildignore.
let NERDTreeRespectWildIgnore=1

" Show hidden files and folders by default.
let NERDTreeShowHidden=1

" Hide the help message.
let NERDTreeMinimalUI=1
