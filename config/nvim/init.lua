require('config.options')
require('config.plugins')
require('config.lsp')
require('config.cmp')

require('config.evil_lualine')
require('config.dashboard')

require('onedark').setup { style = 'dark' }
require('onedark').load()
-- vim.g.airline_theme = 'onedark'

require('nvim-tree').setup()
-- require('telescope').load_extension('media_files')
local find_command = { 'rg', '--hidden', '--files' }
require('telescope').setup{
    defaults = {
        layout_config = {
            prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
    },
    pickers = {
        oldfiles = { find_command = find_command },
        find_files = { find_command = find_command },
        live_grep = { find_command = find_command },
    }
}

vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_url_maxsave = 0
vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.wiki'} }
vim.cmd[[
    autocmd FileType vimwiki setlocal nowrap concealcursor=
]]

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
