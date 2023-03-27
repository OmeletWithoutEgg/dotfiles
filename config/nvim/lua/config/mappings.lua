local M = {}

vim.g.mapleader = '\\'

local function join(list)
    local first = true
    local res = ''
    for _, key in ipairs(list) do
        if not first then res = res .. ' ' end
        first = false
        res = res .. key -- (key_labels[key] or key)
    end
    return res
end

local function snake_style(s)
    return string.gsub(s, ' ', '_')
end

local function add_group(group, leader, mappings)
    local mapping = { name = group }
    for keybind, detail in pairs(mappings) do
        local rhs, desc = unpack(detail)
        desc = group .. '.' .. snake_style(desc)
        local parsed = require('which-key.util').parse_keys(leader .. keybind)
        -- print(vim.inspect(desc))
        mapping[keybind] = { rhs, desc }
        M[desc] = {
            shortcut = join(parsed.notation),
            keys = parsed.keys,
            desc = desc,
        }
    end
    local wk = require('which-key')
    wk.register { [leader] = mapping }
end

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<f2>', '<Cmd>NvimTreeToggle<CR>')
map('v', '<', '<gv')
map('v', '>', '>gv')
-- map('v', 'J', [[<Cmd>m+1<CR>gv=gv]])
-- map('v', 'K', [[<Cmd>m-2<CR>gv=gv]])
map('n', '<C-g>', '1<C-g>')

add_group('telescope', '<space>f', {
    r = { '<Cmd>Telescope oldfiles<CR>', 'recent files' },
    f = { '<Cmd>Telescope find_files<CR>', 'files' },
    w = { '<Cmd>Telescope live_grep<CR>', 'live grep' },
    c = { '<Cmd>Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>', 'config files' },
})

local function reload_packer()
    vim.cmd [[wall]]
    require('plenary.reload').reload_module('config.plugins')
    dofile(vim.fn.expand('$MYVIMRC'))
    require('lazy').sync()
end

add_group('packer', '<space>p', {
    p = { '<Cmd>Lazy sync<CR>', 'sync' },
    s = { '<Cmd>Lazy<CR>', 'status' },
    r = { reload_packer, 'reload' }
})

add_group('git_diffview', '<space>g', {
    d = { '<Cmd>DiffviewOpen<CR>', 'open' },
    t = { '<Cmd>DiffviewToggleFiles<CR>', 'toggle files' },
    c = { '<Cmd>DiffviewClose<CR>', 'close' }
})

add_group('nvim_tree', '<space>b', {
    [''] = { '<Cmd>NvimTreeToggle<CR>', 'toggle' }
})

-- local function treehop()
--   require('tsht').move({ side = "start" })
-- end

add_group('hop', '<space>j', {
    [''] = { '<Cmd>HopWord<CR>', 'word' },
    -- [''] = { treehop, 'treesitter' }
    -- l = { '<Cmd>HopVertical<CR>', 'line' },
    -- ['/'] = { '<Cmd>HopPattern<CR>', 'pattern' },
})

add_group('treesitter', '<space>t', {
    t = { '<Cmd>TSUpdate<CR>', 'update' },
    h = { '<Cmd>TSToggle highlight<CR>', 'toggle highlight' },
})

add_group('appearance', '<space>a', {
    c = { '<Cmd>Telescope colorscheme<CR>', 'colorschemes' },
    t = { '<Cmd>TransparentToggle<CR>', 'toggle transparent' },
})

return M
