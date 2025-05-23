if &buftype != 'nofile'
  setlocal colorcolumn=60
endif

nnoremap <buffer> <leader>t :TableFormat<CR>
nnoremap <buffer> <leader>fm :w<bar>!markdownlint % --fix<CR>
