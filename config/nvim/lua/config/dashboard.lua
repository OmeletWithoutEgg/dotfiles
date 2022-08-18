local db = require('dashboard')

-- db.preview_command = 'cat | lolcat -F 0.3'
-- db.preview_file_path = vim.fn.stdpath('config') .. '/static/neovim.cat'
-- db.preview_file_height = 10
-- db.preview_file_width = 55

-- db.preview_command = 'ueberzug'
-- db.preview_file_path = '~/Pictures/unknown.png'
-- db.preview_file_height = 10
-- db.preview_file_width = 40

local group = vim.api.nvim_create_augroup('custom_highlight', { clear = false })
vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#a5d6ff' })
        vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#98c379' })
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#e5c07b' })
        vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = '#89ddff' })
    end
})

db.hide_statusline = false
db.hide_tabline = false

db.header_pad = 5
db.custom_header = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ',
}

-- string right padding https://snipplr.com/view/13091/strrpad--pad-string-to-the-right
local rpad = function(str, len, char)
    if char == nil then char = ' ' end
    return str .. string.rep(char, len - #str)
end

local make_shortcut = function(opts)
    if opts.source then
        local mapping = require('config.mappings')[opts.source]
        opts.action   = mapping.action
        opts.desc     = mapping.desc
        opts.shortcut = mapping.shortcut
    end
    local icon_fg = '#e86671'
    opts.icon_hl = { fg = icon_fg }
    opts.desc = rpad(opts.desc, 30)
    opts.shortcut = rpad(opts.shortcut, 15)
    return opts
end

db.custom_center = {
    make_shortcut {
        icon = '  ',
        source = 'packer_sync'
    },
    make_shortcut {
        icon = '  ',
        source = 'recent_files'
    },
    make_shortcut {
        icon = '  ',
        source = 'find_files'
    },
    make_shortcut {
        icon = '  ',
        source = 'live_grep'
    },
    make_shortcut {
        icon = '  ',
        source = 'config_files'
    },
    make_shortcut {
        icon = '  ',
        source = 'colorschemes'
    },
    make_shortcut {
        icon = '  ',
        desc = 'Open Vimwiki Index',
        action = 'VimwikiIndex',
        shortcut = [[<leader> w w]],
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
