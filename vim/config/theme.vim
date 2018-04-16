" Enable 24-bit colors.
if (has('termguicolors'))
    set termguicolors
endif

" Customize the color scheme.
let s:colors = onedark#GetColors()

autocmd ColorScheme * call onedark#set_highlight('NERDTreeGitStatusModified', { 'fg': s:colors.yellow })
autocmd ColorScheme * call onedark#set_highlight('NERDTreeGitStatusAdded', { 'fg': s:colors.green })
autocmd ColorScheme * call onedark#set_highlight('CursorLineNr', { 'fg': s:colors.white })
autocmd ColorScheme * call onedark#set_highlight('EndOfBuffer', { 'fg': s:colors.black })
autocmd ColorScheme * call onedark#set_highlight('NERDTreeDir', { 'fg': s:colors.white })
autocmd ColorScheme * call onedark#set_highlight('NERDTreeCWD', { 'fg': s:colors.blue })
autocmd ColorScheme * call onedark#set_highlight('VertSplit', { 'bg': s:colors.cursor_grey, 'fg': s:colors.cursor_grey })

autocmd ColorScheme * call onedark#extend_highlight('NERDTreeCWD', { 'gui': 'bold' })

" Set the color scheme to One Dark.
colorscheme onedark

" Create the Lightline theme.
let s:inactive_fg_grey = [ '#666f7c', s:colors.cursor_grey.cterm ]
let s:inactive_grey = [ '#353b44', s:colors.cursor_grey.cterm ]
let s:cursor_grey = [ s:colors.cursor_grey.gui, s:colors.cursor_grey.cterm ]
let s:yellow = [ s:colors.yellow.gui, s:colors.yellow.cterm ]
let s:purple = [ s:colors.purple.gui, s:colors.purple.cterm ]
let s:white = [ s:colors.white.gui, s:colors.white.cterm ]
let s:green = [ s:colors.green.gui, s:colors.green.cterm ]
let s:black = [ s:colors.black.gui, s:colors.black.cterm ]
let s:grey = [ s:colors.visual_grey.gui, s:colors.cursor_grey.cterm ]
let s:blue = [ s:colors.blue.gui, s:colors.blue.cterm ]
let s:red = [ s:colors.red.gui, s:colors.red.cterm ]

let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {} }

let s:p.normal.left = [ [ s:black, s:green ], [ s:white, s:grey ] ]
let s:p.normal.middle = [ [ s:white, s:cursor_grey ] ]
let s:p.normal.right = [ [ s:black, s:green ], [ s:white, s:grey ] ]
let s:p.normal.error = [ [ s:black, s:red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let s:p.inactive.left =  [ [ s:inactive_fg_grey, s:inactive_grey ], [ s:inactive_fg_grey, s:inactive_grey ] ]
let s:p.inactive.middle = [ [ s:cursor_grey, s:cursor_grey ] ]
let s:p.inactive.right = [ [ s:inactive_fg_grey, s:inactive_grey ], [ s:inactive_fg_grey, s:inactive_grey ] ]

let s:p.insert.left = [ [ s:black, s:blue ], [ s:white, s:grey ] ]
let s:p.insert.right = [ [ s:black, s:blue ], [ s:white, s:grey ] ]

let s:p.replace.left = [ [ s:black, s:red ], [ s:white, s:grey ] ]
let s:p.replace.right = [ [ s:black, s:red ], [ s:white, s:grey ] ]

let s:p.visual.left = [ [ s:black, s:purple ], [ s:white, s:grey ] ]
let s:p.visual.right = [ [ s:black, s:purple ], [ s:white, s:grey ] ]

let s:p.tabline.left = [ [ s:white, s:grey ] ]
let s:p.tabline.tabsel = [ [ s:black, s:grey ] ]
let s:p.tabline.middle = [ [ s:white, s:grey ] ]
let s:p.tabline.right = [ [ s:white, s:grey ] ]

let g:lightline#colorscheme#onedark#palette = lightline#colorscheme#flatten(s:p)

" Configure the Lightline.
let g:lightline={
    \ 'component_function': {
    \   'fileencoding': 'LightlineFileEncoding',
    \ },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'colorscheme': 'onedark',
    \ 'component': {
    \   'lineinfo': "%{&filetype ==# 'nerdtree' ? '' : line('.').'/'.line('$').':'.col('.')}",
    \   'filename': "%{&filetype ==# 'nerdtree' ? '' : expand('%:M')}",
    \   'modified': "%{&filetype ==# 'nerdtree' || !&modified ? '' : '+'}",
    \   'filetype': "%{&filetype ==# 'nerdtree' ? '' : &ft}",
    \   'paste': "%{&filetype ==# 'nerdtree' || !&paste ? '' : 'PASTE'}",
    \   'mode': "%{&filetype ==# 'nerdtree' ? '' : lightline#mode()}",
    \ },
    \ 'inactive': {
    \   'right' : [ [ 'lineinfo' ], [ 'fileencoding', 'filetype' ] ],
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
    \ },
    \ 'active': {
    \   'right': [ [ 'lineinfo' ], [ 'fileencoding', 'filetype' ] ],
    \ },
    \ }

function! LightlineFileEncoding()
    if &filetype ==# 'nerdtree'
        return ''
    endif

    return &fenc !=# '' ? &fenc : &enc
endfunction

" Make sure only the cursor line number is visible.
hi clear CursorLine

" Make sure all the directory parts in NERDTree are the same color.
hi link NERDTreeOpenable NERDTreeDir
hi link NERDTreeClosable NERDTreeDir
hi link NERDTreeDirSlash NERDTreeDir

" Make the "change and delete" sign the same color as the "change" sign.
hi link GitGutterChangeDelete GitGutterChange
