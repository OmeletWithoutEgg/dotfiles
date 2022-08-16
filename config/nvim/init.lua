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

map('n', '<f2>', '<Cmd>NvimTreeToggle<CR>')
map('n', '<leader>rl', '<Cmd>wall <bar> source $MYVIMRC <bar> ' ..
    'lua require("plenary.reload").reload_module("config.plugins", false)<CR>')

vim.cmd [[nohlsearch]]

-- TODO map packersync and gitdiff
