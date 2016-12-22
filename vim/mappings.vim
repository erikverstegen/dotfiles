" Window movement shortcuts.
"
" Move to the window in the direction shown, or create a new window.
"
" Credit: https://github.com/nicknisi/dotfiles/blob/master/config/nvim/autoload/functions.vim
function! WinMove(key)
    let t:curwin = winnr()

    exec "wincmd ".a:key

    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif

        exec "wincmd ".a:key
    endif
endfunction

" Set the leader key.
let mapleader=","

" Faster saving.
nmap <Leader>w :w!<CR>

" Move around the windows with `Ctrl + hjkl`.
map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>
