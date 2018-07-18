" Set the leader key to `,`.
let mapleader='\,'

" Move around the windows with `ctrl + h/j/k/l`.
map <silent> <C-h> <C-w>h
map <silent> <C-j> <C-w>j
map <silent> <C-k> <C-w>k
map <silent> <C-l> <C-w>l

" Turn off search highlighting with `, + esc`.
nnoremap <silent> <CR> :noh<CR><CR>

" Resize buffers using `+` and `-`.
map <silent> + :res +5<CR>
map <silent> - :res -5<CR>
