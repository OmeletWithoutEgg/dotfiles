" nnoremap <buffer> <leader>b :w<bar>execute '!gcc % -o %:r ' . g:gcc_compile_flag<CR>
nnoremap <buffer> <leader>r :!./%:r<CR>
