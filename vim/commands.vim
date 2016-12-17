" :W to save the file with `sudo`.
command W w !sudo tee % >/dev/null

" Remove whitespaces on save.
autocmd BufWritePre * :%s/\s\+$//e
