local db = require('dashboard')

-- db.preview_command = 'cat | lolcat -F 0.3'
-- db.preview_file_path = vim.fn.stdpath('config') .. '/static/neovim.cat'
-- db.preview_file_height = 10
-- db.preview_file_width = 55

-- db.preview_command = 'ueberzug'
-- db.preview_file_path = '~/Pictures/unknown.png'
-- db.preview_file_height = 10
-- db.preview_file_width = 40

local group = vim.api.nvim_create_augroup('custom_highlight', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme',{
    group = group,
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#a5d6ff' })
        vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#98c379' })
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#e5c07b' })
    end
})

db.header_pad = 10
db.custom_header = {
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

db.custom_center = {
    {
        icon = '  ',
        desc = 'Find Recent Files                       ',
        -- action =  'Telescope oldfiles',
        shortcut = 'SPC f r',
        mapping = '<space>fr',
    },
    {
        icon = '  ',
        desc = 'Find Files                              ',
        -- action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC f f',
        mapping = '<space>ff',
    },
    {
        icon = '  ',
        desc = 'Find word                               ',
        -- action = 'Telescope live_grep',
        shortcut = 'SPC f w',
        mapping = '<space>fw',
    },
    {
        icon = '  ',
        desc = 'Open Neovim Config                      ',
        -- action = 'Telescope find_files find_command=rg,--hidden,--files cwd=' .. vim.fn.stdpath('config'),
        shortcut = 'SPC n c',
        mapping = '<space>nc',
    },
}

db.custom_footer = function()
    local default_footer = { '', ' Have fun with neovim' }
    if packer_plugins ~= nil then
        local count = #vim.tbl_keys(packer_plugins)
        default_footer[2] = ' neovim loaded ' .. count .. ' plugins'
    end
    return default_footer
end
