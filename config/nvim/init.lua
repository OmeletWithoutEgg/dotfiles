require('plugins')

local o = vim.opt
o.guicursor = ''
o.termguicolors = true
o.background = 'dark'
vim.cmd[[
au ColorScheme *
            \ hi Comment cterm=NONE gui=NONE |
            \ hi Search ctermfg=yellow guifg=yellow |
            \ hi CursorLine term=NONE cterm=NONE |
            \ hi CursorLineNr cterm=NONE
            " \ au ColorScheme * hi Normal guibg=NONE " make transparent
]]
vim.cmd[[colorscheme vim-material]]

o.number = true
o.relativenumber = true
o.cindent = true
o.expandtab = true
o.shiftwidth=4
o.softtabstop=4
o.hlsearch = true

o.laststatus = 2
o.mouse = 'a'
o.cinoptions = 'j1'
o.cursorline = true
o.showmode = false
o.lazyredraw = true
o.autochdir = true
o.showcmd = true
o.ttimeoutlen = 0

require('lsp')
-- require('lualine').setup({
--     options = { theme = 'material' },
-- })
require('nvim-tree').setup()

require('goto-preview').setup {}

vim.g.airline_theme = 'onedark'

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}

  if opts then options = vim.tbl_extend('force', options, opts) end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<f2>', ':NvimTreeToggle<CR>', { silent = true })
