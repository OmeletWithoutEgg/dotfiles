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
vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#a5d6ff' })
        vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#98c379' })
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#e5c07b' })
    end
})

db.hide_statusline = false

db.header_pad = 10
db.custom_header = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

local icon_fg = '#e86671'

db.custom_center = {
    {
        icon = '  ',
        icon_hl = { fg = icon_fg },
        desc = 'Find Recent Files                       ',
        -- action =  'Telescope oldfiles',
        shortcut = 'SPC f r',
    },
    {
        icon = '  ',
        icon_hl = { fg = icon_fg },
        desc = 'Find Files                              ',
        -- action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC f f',
    },
    {
        icon = '  ',
        icon_hl = { fg = icon_fg },
        desc = 'Find Word                               ',
        -- action = 'Telescope live_grep',
        shortcut = 'SPC f w',
    },
    {
        icon = '  ',
        icon_hl = { fg = icon_fg },
        desc = 'Find Config Files                       ',
        -- action = 'Telescope find_files find_command=rg,--hidden,--files cwd=' .. vim.fn.stdpath('config'),
        shortcut = 'SPC f c',
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

-- TODO Do not Repeat Yourself
local wk = require('which-key')
wk.register({
    ['<space>f'] = {
        name = 'file',
        r = { '<Cmd>Telescope oldfiles<CR>',                                          'Find recent files'    },
        f = { '<Cmd>Telescope find_files<CR>',                                        'Find files'           },
        w = { '<Cmd>Telescope live_grep<CR>',                                         'Find word'           },
        c = { '<Cmd>Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>', 'Find config files'    },
    }
})
