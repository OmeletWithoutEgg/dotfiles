require('config.options')
require('config.plugins')
require('config.lsp')
require('config.cmp')

require('config.evil_lualine')
require('config.dashboard')

-- vim.g.airline_theme = 'onedark'

vim.g.mapleader = '\\'

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<f2>', ':NvimTreeToggle<CR>')
map('n', '<leader>rl', ':source $MYVIMRC<CR>')

-- map('n', '<space>sl', ':SessionLoad')
map('n', '<space>fr', ':Telescope oldfiles<CR>')
map('n', '<space>ff', ':Telescope find_files<CR>')
map('n', '<space>fw', ':Telescope live_grep<CR>')
map('n', '<space>nc', ':Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>')

vim.cmd[[nohlsearch]]
