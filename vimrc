" source ~/vir/.vimrc | finish

set nocompatible
set encoding=utf8
set fileencoding=utf8
set fileformat=unix

call plug#begin()

""" Appearance
Plug 'hzchirs/vim-material'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'

""" File browser & git tools
Plug 'preservim/nerdtree' " <F2> for toggle nerdtree
Plug 'ryanoasis/vim-devicons'
Plug 'bryanmylee/vim-colorscheme-icons'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin' " git status
" Plug 'mhinz/vim-signify'
" let g:signify_skip_filetype = { 'vim': 1, 'c': 1 , 'cpp': 1 }
" Plug 'mileszs/ack.vim'

""" Language-specific
Plug 'ap/vim-css-color'
" Plug 'dense-analysis/ale'
" Plug 'maximbaz/lightline-ale'
" Plug 'sheerun/vim-polyglot'
Plug 'cespare/vim-toml' " TOML syntax highlight
Plug 'itchyny/vim-haskell-indent'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'zirrostig/vim-jack-syntax'
Plug 'petRUShka/vim-sage'
Plug 'isobit/vim-caddyfile'
Plug 'posva/vim-vue'
" Plug 'vim-latex/vim-latex'
Plug 'preservim/vim-markdown'
Plug 'godlygeek/tabular'
" Plug 'joker1007/vim-markdown-quote-syntax'

""" Functional
Plug 'vimwiki/vimwiki'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'tpope/vim-commentary' " gc for comment
" Plug 'tpope/vim-surround'
" Plug 'terryma/vim-expand-region' " +/_ for expand/shrink visual select region
" Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'kevinhwang91/vim-ibus-sw'
" Plug 'lilydjwg/fcitx.vim'
" let g:fcitx5_remote = 'fcitx5-remote'
Plug 'sirver/ultisnips', { 'for': [ 'tex', 'plaintex', 'snippets' ] }

call plug#end()

""" <Plug> vim-material
au ColorScheme *
            \ hi Comment cterm=NONE gui=NONE |
            \ hi Search ctermfg=yellow guifg=yellow |
            \ hi CursorLine term=NONE cterm=NONE |
            \ hi CursorLineNr cterm=NONE
            " \ au ColorScheme * hi Normal guibg=NONE " make transparent
set background=dark
color vim-material
""" <Plug> lightline
let g:lightline = {
    \   'colorscheme': 'materia',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified', 'gitbranch' ], ],
    \       'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \   },
    \   'component_function': {
    \       'gitbranch': 'FugitiveHead',
    \   },
    \ }
""" <Plug> startify
let g:startify_custom_header = startify#center(['VIM - Vi IMproved', 'JIZZZZZZZZZZZZZZZ', '@OmeletWithoutEgg'])
let g:startify_bookmarks = ['~/.vimrc']
""" <Plug> nerdtree
nnoremap <silent> <F2> :if expand('%') <bar> cd %:h <bar> endif <bar> NERDTreeToggle <bar> call lightline#update()<CR>
let g:NERDTreeSortOrder = ['\/$', '*', '\.swp$',  '\.bak$', '\~$', '[[extension]]', '[[-timestamp]]']
" autocmd FileType nerdtree setlocal nolist
""" <Plug> indentLine
let g:indentLine_fileTypeExclude = ['startify', 'vimwiki']
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']
""" <Plug> vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1 " YAML
let g:vim_markdown_math = 1
""" <Plug> vim-tabular
let g:tex_conceal='' " tabular
""" <Plug> vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_url_maxsave = 0
au ColorScheme *
            \ hi VimwikiHeader1 guifg=#89DDFF |
            \ hi VimwikiHeader2 guifg=#C3E88D |
            \ hi VimwikiHeader3 guifg=#FFCB6B |
            \ hi VimwikiHeader4 guifg=#F07178 |
au FileType vimwiki setlocal nowrap concealcursor=
" let wiki = {}
" let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
""" <Plug> ultisnips
let g:UltiSnipsExpandTrigger = '<space>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
" let g:UltiSnipsListSnippets = '<C-H>'

""" Basic
syntax on
set nu rnu cin bs=2 et sw=4 sts=4 hls
set belloff=all laststatus=2 mouse=a cino=j1
set cursorline noshowmode lazyredraw termguicolors autochdir showcmd
set ttimeoutlen=0
set wildmenu wildoptions=pum
" set listchars=trail:␣,eol:$,tab:►\ ,extends:⟩,precedes:⟨,space:·,trail:•

augroup rnutoggle
    au!
    au InsertEnter * set nornu
    au InsertLeave * if expand('%') != '' | set rnu | endif
augroup END

inoremap {<CR> {<CR>}<C-o>O
" nnoremap <silent> <C-n> :tabnew<CR>:Startify<CR>
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap <C-g> 1<C-g>
command Codeforces %d<bar>r ~/CompetitiveProgramming/templates/main.cpp<bar>1d<bar>15,101fo<bar>111

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

function s:LaTeXMapping()
    nnoremap <buffer> <leader>b :w<bar>!make<CR>
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
endfunction

function s:MarkdownMapping()
    nnoremap <buffer> <leader>t :TableFormat<CR>
endfunction

function s:VimwikiMapping()
    nnoremap <buffer> <space> <Plug>VimwikiToggleListItem
endfunction

augroup mappingHandler
    au!
    au FileType c call <SID>CMapping()
    au FileType cpp call <SID>CppMapping()
    au FileType haskell call <SID>HaskellMapping()
    au FileType python call <SID>PythonMapping()
    au FileType sage call <SID>SageMapping()
    au FileType vim call <SID>VimrcMapping()
    au FileType tex,plaintex call <SID>LaTeXMapping()
    au FileType markdown call <SID>MarkdownMapping()
    au FileType vimwiki call <SID>VimwikiMapping()
augroup END

function s:JSFormat()
    setlocal cc=100
    " setlocal sts=2 sw=2 cc=100
endfunction

function s:TeXFormat()
    setlocal foldmethod=marker
    setlocal cc=100
endfunction

augroup formattingHandler
    au!
    au FileType javascript,vue call <SID>JSFormat()
    au FileType vue,c,cpp,html,markdown syntax sync fromstart
    au FileType tex,plaintex call <SID>TeXFormat()
augroup END

nmap <F9> <leader>b
nmap <F10> <leader>r

noh

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
" let &t_ut='' " kitty

if (&term == "alacritty" || &term == "kitty")
    let &term = "xterm-256color"
endif
