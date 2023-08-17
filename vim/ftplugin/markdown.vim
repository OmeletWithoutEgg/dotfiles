setlocal colorcolumn=60

nnoremap <buffer> <leader>t :TableFormat<CR>
nnoremap <buffer> <leader>fm :w<bar>!markdownlint % --fix<CR>
