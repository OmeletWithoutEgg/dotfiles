let g:gcc_compile_flag = '-g -Dlocal -Ofast -Wall -Wextra -Wshadow -Wconversion -Wfatal-errors -fsanitize=undefined,address'

function s:CMapping()
    nnoremap <buffer> <leader>b :w<bar>execute '!gcc % -o %:r ' . g:gcc_compile_flag<CR>
    nnoremap <buffer> <leader>r :!./%:r<CR>
endfunction

function s:CppMapping()
    " nnoremap <F8> :w<bar>!./run.sh<CR>
    nnoremap <buffer> <leader>b :w<bar>execute '!g++ % -o %:r -std=c++17 ' . g:gcc_compile_flag<CR>
    nnoremap <buffer> <leader>r :!./%:r<CR>
endfunction

function s:PythonMapping()
    nnoremap <buffer> <leader>r :w<bar>!python3 %<CR>
endfunction

function s:SageMapping()
    nnoremap <buffer> <leader>r :w<bar>!sage %<CR>
endfunction

function s:VimrcMapping()
    nnoremap <buffer> <leader>r :w<bar>so %<CR>
endfunction

function s:ShellScriptMapping()
    nnoremap <buffer> <leader>r :w<bar>!bash %<CR>
endfunction

function s:LaTeXMapping()
    " nnoremap <buffer> <leader>b :w<bar>!make<CR>
    nnoremap <buffer> <leader>r :!okular --unique main.pdf &<CR>
    " inoremap <buffer> <leader>bm \begin{bmatrix}<CR>\end{bmatrix}<ESC>O
    " inoremap <buffer> <leader>bee \begin{enumerate}<CR>\end{enumerate}<ESC>O
    " inoremap <buffer> <leader>bei \begin{itemize}<CR>\end{itemize}<ESC>O
    " inoremap <buffer> <leader>bea \begin{align*}<CR>\end{align*}<ESC>O
    " inoremap <buffer> <leader>bf \begin{frame}{}<CR>\end{frame}<ESC>O
    " inoremap <buffer> <leader>bb \begin{block}{}<CR>\end{block}<ESC>O
    " inoremap <buffer> <leader>env <ESC>^"pc$\begin{<C-o>"pp}<CR>\end{<C-o>"pp}<ESC>O
endfunction

function s:HaskellMapping()
    nnoremap <buffer> <leader>b :w<bar>!ghc % -o %:r -dynamic<CR>
    nnoremap <buffer> <leader>r :!./%:r<CR>
    nnoremap <buffer> <leader>i :w<bar>!ghci %<CR>
endfunction

function s:MarkdownMapping()
    nnoremap <buffer> <leader>t :TableFormat<CR>
endfunction

function s:VimwikiMapping()
    nnoremap <buffer> <space> <Plug>VimwikiToggleListItem
    nnoremap <buffer> = <nop>
    nnoremap <buffer> - <nop>
    nnoremap <buffer> # <Plug>VimwikiAddHeaderLevel
    nnoremap <buffer> L <Plug>VimwikiFollowLink
    nnoremap <buffer> H <Plug>VimwikiGoBackLink
endfunction

augroup mappingHandler
    au!
    au FileType c call <SID>CMapping()
    au FileType cpp call <SID>CppMapping()
    au FileType haskell call <SID>HaskellMapping()
    au FileType python call <SID>PythonMapping()
    au FileType sage.python call <SID>SageMapping()
    au FileType vim call <SID>VimrcMapping()
    au FileType tex,plaintex call <SID>LaTeXMapping()
    au FileType markdown call <SID>MarkdownMapping()
    au FileType vimwiki call <SID>VimwikiMapping()
    au FileType sh call <SID>ShellScriptMapping()
    nnoremap <leader>m :w<bar>!make test<CR>
augroup END

function s:JSFormat()
    setlocal cc=100
    " setlocal sts=2 sw=2 cc=100
endfunction

function s:TeXFormat()
    setlocal foldmethod=marker
    " setlocal cc=80
    " setlocal textwidth=80
    " setlocal wrapmargin=0
    " setlocal formatoptions+=t
    " setlocal linebreak
endfunction

augroup formattingHandler
    au!
    au FileType javascript,vue call <SID>JSFormat()
    au FileType vue,c,cpp,html,markdown,vimwiki,tex,plaintex syntax sync fromstart
    au FileType tex,plaintex call <SID>TeXFormat()
augroup END
