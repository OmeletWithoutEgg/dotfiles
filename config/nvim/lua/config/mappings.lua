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
    C = { '<Cmd>Telescope colorscheme<CR>', 'colorschemes' },
})

local reload_packer = function()
    vim.cmd [[wall]]
    require('plenary.reload').reload_module('config.plugins')
    dofile(vim.fn.expand('$MYVIMRC'))
    require('packer').sync()
end

add_group('packer', '<space>p', {
    p = { '<Cmd>PackerSync<CR>', 'sync' },
    s = { '<Cmd>PackerStatus<CR>', 'status' },
    r = { reload_packer, 'reload' }
})

-- local toggle_onedark = function()
--     require('onedark').toggle()
--     print('current style =', vim.g.onedark_config.style)
-- end
-- add_group('toggle', '<space>t', {
--     onedark_style = { 's', toggle_onedark, 'Toggle Onedark Style' }
-- })

add_group('git', '<space>g', {
    d = { '<Cmd>DiffviewOpen<CR>', 'diffview open' },
    t = { '<Cmd>DiffviewToggleFiles<CR>', 'diffview toggle files' },
    c = { '<Cmd>DiffviewClose<CR>', 'diffview close' }
    -- TODO
})
-- TODO map gitdiff

add_group('nvim_tree', '<space>b', {
    [''] = { '<Cmd>NvimTreeToggle<CR>', 'toggle' }
})

-- place this in one of your configuration file(s)
-- local hop = require('hop')
-- local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})

return M
