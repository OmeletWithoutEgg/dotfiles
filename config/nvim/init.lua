require('config.options')
require('config.plugins')
require('config.mappings')
require('config.lsp')
-- require('config.cmp')

require('config.lualine')
require('config.dashboard')

local group = vim.api.nvim_create_augroup('CustomVimMaterial', {})
vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = 'vim-material',
    callback = function()
        vim.cmd [[
            hi Comment cterm=NONE gui=NONE |
            hi Search ctermfg=yellow guifg=yellow |
            hi CursorLine term=NONE cterm=NONE |
            hi CursorLineNr cterm=NONE |
            hi Normal guibg=NONE " make transparent
        ]]
    end
})

vim.cmd [[colorscheme vim-material]]

-- require('onedark').load()
-- vim.g.airline_theme = 'onedark'
-- vim.g.airline_left_sep = ''
-- vim.g.airline_left_alt_sep = ''
-- vim.g.airline_right_sep = ''
-- vim.g.airline_right_alt_sep = ''
-- vim.g.airline_symbols = { linenr = '␊' }

-- require('lualine').setup {
--     options = {
--         theme = 'material',
--         icons_enabled = false,
--     },
-- }

vim.cmd [[nohlsearch]]

require('hologram').setup { auto_display = true }
