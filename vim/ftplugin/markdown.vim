" if exists('b:did_ftplugin')
"     finish
" endif
" let b:did_ftplugin = 1

nnoremap <buffer> <leader>t :TableFormat<CR>
nnoremap <buffer> <leader>fm :w<bar>!markdownlint % --fix<CR>
