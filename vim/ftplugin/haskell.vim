if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

nnoremap <buffer> <leader>b :w<bar>!ghc % -o %:r -dynamic<CR>
nnoremap <buffer> <leader>r :!./%:r<CR>
nnoremap <buffer> <leader>i :w<bar>!ghci %<CR>

setlocal foldmethod=marker
" setlocal cc=80
" setlocal textwidth=80
" setlocal wrapmargin=0
" setlocal formatoptions+=t
" setlocal linebreak
