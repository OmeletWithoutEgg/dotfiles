nmap <buffer> <space>c <Plug>VimwikiToggleListItem
nnoremap <buffer> = <nop>
nnoremap <buffer> - <nop>
nmap <buffer> # <Plug>VimwikiAddHeaderLevel
nmap <buffer> <C-N> <Plug>VimwikiNextLink
nmap <buffer> <C-P> <Plug>VimwikiPrevLink

" nnoremap <buffer> L <Plug>VimwikiFollowLink
" nnoremap <buffer> H <Plug>VimwikiGoBackLink

nnoremap <buffer> <leader>fm :w<bar>!markdownlint % --fix<CR>

setlocal nowrap concealcursor=

function s:hiheader()
  hi VimwikiHeader1 guifg=#89DDFF
  hi VimwikiHeader2 guifg=#C3E88D
  hi VimwikiHeader3 guifg=#FFCB6B
  hi VimwikiHeader4 guifg=#F07178
endfunction

augroup vimwiki_custom_header_color
  autocmd!
  autocmd ColorScheme * call <SID>hiheader()
augroup END

call <SID>hiheader()
