let g:gitgutter_override_sign_column_highlight = 0

" Set the Vim color scheme to Base16 Ocean.
let base16colorspace=256

colorscheme base16-ocean

" Hide the end of buffer text.
highlight EndOfBuffer ctermfg=bg

" Customize the current line number color.
highlight CursorLineNr ctermfg=007

" Make the line number background color the same as the regular background
" color.
highlight LineNr ctermbg=bg

" Make the signs background color the same as the regular background color.
highlight GitGutterChangeDelete ctermbg=bg ctermfg=003
highlight GitGutterDelete ctermbg=bg
highlight GitGutterChange ctermbg=bg ctermfg=003
highlight GitGutterAdd ctermbg=bg
highlight SignColumn ctermbg=bg

" Make the invisibles less pronounced.
highlight NonText ctermfg=240

" Improve PHP syntax highlighting.
function! PhpSyntaxOverride()
    hi! def link phpType phpKeyword
    hi! def link phpInclude phpKeyword
    hi! def link phpClassExtends String
    hi! def link phpClassImplements String
    hi! def link phpClass Type
    hi! def link phpMethods Type
    hi! def link phpFunction Function
    hi! def link phpVarSelector phpIdentifier
    hi! def link phpFunctionTypeHint Type

    hi! def link phpDocTags phpKeyword
    hi! def link phpDocRealTags phpKeyword
    hi! def link phpDocRealParam Type
    hi! def link phpDocIdentifier phpIdentifier

    syn match phpDocRealTags "@\%(param\|return\|throws\|var\)" containedin=phpDocComment nextgroup=phpDocRealParam skipwhite
    syn match phpDocRealParam "\s\+\zs\%(\S*|\?\)\+" nextgroup=phpDocIdentifier skipwhite
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END
