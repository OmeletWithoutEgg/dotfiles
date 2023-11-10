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
" Plug 'Yggdroot/indentLine'
Plug 'tribela/vim-transparent'

""" File browser & icons & git tools
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-signify'
" let g:signify_skip_filetype = { 'vim': 1, 'c': 1 , 'cpp': 1 }

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'csch0/vim-startify-renderer-nerdfont'
Plug 'lambdalisue/glyph-palette.vim'

""" Language-specific
Plug 'kchmck/vim-coffee-script'
Plug 'ap/vim-css-color'
" Plug 'dense-analysis/ale'
" Plug 'maximbaz/lightline-ale'
" Plug 'sheerun/vim-polyglot'
Plug 'cespare/vim-toml'
Plug 'itchyny/vim-haskell-indent'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'zirrostig/vim-jack-syntax'
Plug 'petRUShka/vim-sage'
Plug 'isobit/vim-caddyfile'
Plug 'posva/vim-vue'
Plug 'philj56/vim-asm-indent'

""" Functional
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' " gc for comment
Plug 'suy/vim-context-commentstring'
" Plug 'inkarkat/vim-ReplaceWithRegister' " gr for replace
" Plug 'terryma/vim-expand-region' " +/_ for expand/shrink visual select region
" Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'kevinhwang91/vim-ibus-sw', { 'commit': '83bcdce5cd5c0ef7b129916ea4fb3be27194230b' }
" Plug 'lilydjwg/fcitx.vim'
" let g:fcitx5_remote = 'fcitx5-remote'

Plug 'vimwiki/vimwiki', { 'branch': 'master' }
" Plug 'vim-latex/vim-latex'
Plug 'preservim/vim-markdown'
Plug 'godlygeek/tabular'
" Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'lervag/vimtex'
" Plug 'sirver/ultisnips', { 'for': [ 'tex', 'plaintex', 'snippets' ] }

Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
nnoremap <silent> <space>ac :FzfColors<CR>
nnoremap <silent> <space>ff :FzfFiles<CR>
nnoremap <silent> <space>fr :FzfHistory<CR>

call plug#end()

nnoremap <silent> <space>pp :PlugUpgrade<bar>PlugUpdate<CR>

""" UI plugins {{{
""" <Plug> vim-material
au ColorScheme *
      \ hi Comment cterm=NONE gui=NONE |
      \ hi Search ctermfg=yellow guifg=yellow |
      \ hi CursorLine term=NONE cterm=NONE |
      \ hi CursorLineNr cterm=NONE |
      \ hi VertSplit cterm=NONE " |
" \ hi Normal guibg=NONE " make transparent
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
let g:startify_bookmarks = [{ 'c': '~/.vimrc' }]
""" <Plug> fern
nnoremap <silent> <space>e :Fern . -drawer -toggle<CR>
function s:custom_glyph_palette()
  " hi GlyphPalette0 " black
  hi GlyphPalette1 guifg=#FF5370 " red
  hi GlyphPalette2 guifg=#C3E88D " green
  hi GlyphPalette3 guifg=#FFCB6B " yellow
  hi GlyphPalette4 guifg=#89DDFF " blue
  " hi GlyphPalette5 " magenta
  hi GlyphPalette6 guifg=#82AAFF " cyan
  hi GlyphPalette7 guifg=#FFFFFF " white
  " tips: :call glyph_palette#tools#show_palette()
endfunction
augroup my_glyph_palette
  autocmd!
  autocmd ColorScheme * call <SID>custom_glyph_palette()
  autocmd FileType fern,startify call glyph_palette#apply()
augroup END
let g:fern#renderer = 'nerdfont'

""" <Plug> indentLine
let g:indentLine_fileTypeExclude = ['startify', 'vimwiki']
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']
""" <Plug> transparent
nnoremap <silent> <space>at :TransparentToggle<CR>
""" }}}

""" Markdown & Tex & vimwiki {{{
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
""" <Plug> vimtex
let g:vimtex_view_method = 'zathura' " ~/.local/bin/zathura

""" <Plug> vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_url_maxsave = 0
let g:vimwiki_list = [{'path': '~/vimwiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'
" just to override
" let wiki = {}
" let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

" """ <Plug> ultisnips
" let g:UltiSnipsExpandTrigger = '<space>'
" let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
""" }}}

""" Basic Option {{{
syntax on
set nu rnu cin bs=2 et sw=2 sts=2 hls
set belloff=all laststatus=2 mouse=a cino=j1
set cursorline noshowmode lazyredraw termguicolors autochdir showcmd
set ttimeoutlen=0
set wildmenu wildoptions=pum
set listchars=eol:$,tab:►\ ,space:␣,trail:•,extends:⟩,precedes:⟨
set fillchars=vert:│,fold:-,eob:\ 
set smartcase ignorecase incsearch
set foldmethod=marker
""" }}}

augroup rnutoggle
  au!
  au InsertEnter * set nornu
  au InsertLeave * if expand('%') != '' | set rnu | endif
augroup END

inoremap {<CR> {<CR>}<C-o>O
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap <C-g> 1<C-g>

let g:gcc_compile_flag = '-g -Dlocal -Ofast ' .
      \ '-Wall -Wextra -Wshadow -Wconversion -Wfatal-errors ' .
      \ '-fsanitize=undefined,address'

augroup formattingHandler
  au!
  au FileType vue,c,cpp,html,markdown,vimwiki,tex,plaintex syntax sync fromstart
augroup END

nmap <F9> <leader>b
nmap <F10> <leader>r

noh

" Terminal Emulator Specific problem {{{
" vim hardcodes background color erase even if the
" terminfo file does not contain bce (not to mention that
" libvte based terminals incorrectly contain bce in their
" terminfo files). This causes incorrect background
" rendering when using a color theme with a background color.
" let &t_ut='' " kitty

if (&term == "alacritty" || &term == "kitty")
  let &term = "xterm-256color"
endif
" }}}
