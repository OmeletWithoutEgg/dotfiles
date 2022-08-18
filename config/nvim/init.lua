require('config.options')
require('config.plugins')
require('config.mappings')
require('config.lsp')
-- require('config.cmp')

require('config.dashboard')

local group = vim.api.nvim_create_augroup('custom_highlight', { clear = false })
vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = '*',
    callback = function()
        vim.cmd [[
            hi Comment cterm=NONE gui=NONE |
            hi Search ctermfg=yellow guifg=yellow |
            hi CursorLine term=NONE cterm=NONE |
            hi CursorLineNr cterm=NONE
            " au ColorScheme * hi Normal guibg=NONE " make transparent
        ]]
    end
})
vim.cmd [[colorscheme vim-material]]
vim.g.airline_theme = 'onedark'

vim.cmd [[nohlsearch]]
