" Open NERDTree when Vim starts up in a directory.
autocmd StdinReadPre * let s:std_in=1
autocm VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe "NERDTree" argv()[0] | wincmd p | ene | endif

" Close Vim if NERDTree is the only buffer left.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle NERDTree with `Ctrl + n`.
map <silent> <C-n> :NERDTreeToggle<CR>

" Show hidden files.
let NERDTreeShowHidden=1

" Use a minimal UI.
let NERDTreeMinimalUI=1
