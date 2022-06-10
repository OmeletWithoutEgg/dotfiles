" source ~/vir/.vimrc | finish

set nocompatible
set encoding=utf8
set fileencoding=utf8
set fileformat=unix

call plug#begin('~/.vim/plugged')

Plug 'hzchirs/vim-material'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

Plug 'vimwiki/vimwiki'
let g:vimwiki_global_ext = 0

Plug 'preservim/nerdtree' " <F2> for toggle nerdtree
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin' " git status
Plug 'mhinz/vim-signify'
let g:signify_skip_filetype = { 'vim': 1, 'c': 1 , 'cpp': 1 }

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
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1 " YAML
let g:vim_markdown_math = 1
let g:tex_conceal='' " tabular

" Plug 'tpope/vim-commentary' " gc for comment
" Plug 'tpope/vim-surround'
" Plug 'terryma/vim-expand-region' " +/_ for expand/shrink visual select region
" Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'kevinhwang91/vim-ibus-sw'
" Plug 'lilydjwg/fcitx.vim'
" let g:fcitx5_remote = 'fcitx5-remote'

call plug#end()

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
let g:startify_custom_header = startify#center(['VIM - Vi IMproved', 'JIZZZZZZZZZZZZZZZ', '@OmeletWithoutEgg'])
let g:startify_bookmarks = ['~/.vimrc']

set background=dark
color vim-material
au ColorScheme * hi Comment cterm=NONE gui=NONE | hi Search ctermfg=yellow guifg=yellow
" disable italic comment and enable highlight search color
au ColorScheme * hi CursorLine term=NONE cterm=NONE | hi CursorLineNr cterm=NONE
" disable cursorline and cursorline number underline
" au ColorScheme * hi Normal guibg=NONE

if has('gui_running')
    set guioptions-=m guioptions-=e guioptions-=T guioptions-=L guioptions-=R guioptions-=l guioptions-=r
    """ menu | tab page | toolbar | left scrollbar | right scrollbar | left scrollbar (split) | right scrollbar (split)
    if has('win32')
        au GUIEnter * simalt ~x " maximize window
        set guifont=Microsoft\ Yahei\ Mono:h14 " for Windows
    else
        set guifont=Dejavu\ Sans\ Mono\ 16
    endif
    " set guifontwide=DFKai-SB
endif

syntax on
set nu rnu cin bs=2 et sw=4 sts=4 hls
set belloff=all laststatus=2 mouse=a cino=j1
set cursorline noshowmode lazyredraw termguicolors autochdir showcmd
set ttimeoutlen=0
set listchars=trail:␣,eol:$,tab:►\ ,extends:⟩,precedes:⟨,space:·
" set listchars=tab:→\ ,trail:•
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
command Codeforces %d<bar>r ~/CompetitiveProgramming/templates/main.cpp<bar>1d<bar>15,101fo<bar>111

nnoremap <silent> <F2> :if expand('%') <bar> cd %:h <bar> endif <bar> NERDTreeToggle <bar> call lightline#update()<CR>

function s:CMapping()
    nnoremap <leader>b :w<bar>!gcc % -o %:r -g -Dlocal -Ofast -Wall -Wextra -Wshadow -Wconversion -Wfatal-errors -fsanitize=undefined,address<CR>
    nnoremap <leader>r :!./%:r<CR>
endfunction

function s:CppMapping()
    " nnoremap <F8> :w<bar>!./run.sh<CR>
    nnoremap <leader>b :w<bar>!g++ % -o %:r -std=c++17 -g -Dlocal -Ofast -Wall -Wextra -Wshadow -Wconversion -Wfatal-errors -fsanitize=undefined,address<CR>
    nnoremap <leader>r :!./%:r<CR>
endfunction

function s:PythonMapping()
    nnoremap <silent> <leader>r :w<bar>!python3 %<CR>
endfunction

function s:SageMapping()
    nnoremap <silent> <leader>r :w<bar>!sage %<CR>
endfunction

function s:VimrcMapping()
    nnoremap <silent> <leader>r :w<bar>so %<CR>
endfunction

function s:LaTeXMapping()
    nnoremap <leader>b :w<bar>!make<CR>
    nnoremap <leader>r :!okular --unique main.pdf &<CR>
    inoremap <leader>bm \begin{bmatrix}<CR>\end{bmatrix}<ESC>O
    inoremap <leader>bee \begin{enumerate}<CR>\end{enumerate}<ESC>O
    inoremap <leader>bei \begin{itemize}<CR>\end{itemize}<ESC>O
    inoremap <leader>bea \begin{align*}<CR>\end{align*}<ESC>O
    inoremap <leader>env <ESC>^"pc$\begin{<C-o>"pp}<CR>\end{<C-o>"pp}<ESC>O
endfunction

function s:HaskellMapping()
    nnoremap <leader>b :w<bar>!ghc % -o %:r -dynamic<CR>
    nnoremap <leader>r :!./%:r<CR>
endfunction

function s:MarkdownMapping()
    nnoremap <leader>t :TableFormat<CR>
endfunction

augroup mappingHandler
    au!
    au BufEnter *.c call <SID>CMapping()
    au BufEnter *.cpp call <SID>CppMapping()
    au BufEnter *.hs call <SID>HaskellMapping()
    au BufEnter *.py call <SID>PythonMapping()
    au BufEnter *.sage call <SID>SageMapping()
    au BufEnter *.vim,_vimrc,.vimrc call <SID>VimrcMapping()
    au BufEnter *.tex call <SID>LaTeXMapping()
    au BufEnter *.md call <SID>MarkdownMapping()
augroup END

function s:JSFormat()
    set sts=2 sw=2 cc=100
endfunction

function s:TeXFormat()
    set foldmethod=marker
    set cc=100
endfunction

augroup formattingHandler
    au!
    au BufEnter *.js,*.vue call<SID>JSFormat()
    au FileType vue,c,cpp,html,markdown syntax sync fromstart
    au BufEnter *.tex call<SID>TeXFormat()
augroup END

nmap <F9> <leader>b
nmap <F10> <leader>r

noh
