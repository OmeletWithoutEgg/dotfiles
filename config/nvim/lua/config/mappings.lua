local M = {}

vim.g.mapleader = '\\'

local function abbr(s)
    local key_labels = {
        ['<space>'] = 'SPC',
        -- ['<leader>'] = 'LEA',
    }
    local keys = require('which-key.util')
        .parse_keys(s).notation
    local first = true
    local res = ''
    for _, key in ipairs(keys) do
        if not first then res = res .. ' ' end
        first = false
        res = res .. (key_labels[key] or key)
    end
    -- print(vim.inspect(res))
    return res
end

local function add_group(group, leader, mappings)
    local mapping = { name = group }
    for key, detail in pairs(mappings) do
        local keybind, rhs, desc = unpack(detail)
        mapping[keybind] = { rhs, desc }
        M[key] = {
            shortcut = abbr(leader .. keybind),
            rhs = rhs, -- TODO properly set "action" field
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
map('v', 'J', [[<Cmd>m '>+1<CR>gv=gv]])
map('v', 'K', [[<Cmd>m '<-2<CR>gv=gv]])
map('n', '<C-g>', '1<C-g>')

add_group('telescope', '<space>f', {
    recent_files = { 'r', '<Cmd>Telescope oldfiles<CR>', 'Find Recent Files' },
    find_files   = { 'f', '<Cmd>Telescope find_files<CR>', 'Find Files' },
    live_grep    = { 'w', '<Cmd>Telescope live_grep<CR>', 'Find Word' },
    config_files = { 'c', '<Cmd>Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>', 'Find Config Files' },
    colorschemes = { 'C', '<Cmd>Telescope colorscheme<CR>', 'Check Colorschemes' },
})

local reload_packer = function()
    vim.cmd [[ wall ]]
    require('plenary.reload').reload_module('config.plugins')
    dofile(vim.fn.expand('$MYVIMRC'))
    require('packer').sync()
    require('packer').compile()
end

add_group('packer', '<space>p', {
    packer_sync   = { 'p', '<Cmd>PackerSync<CR>', 'Packer Sync' },
    packer_status = { 's', '<Cmd>PackerStatus<CR>', 'Packer Status' },
    packer_reload = { 'r', reload_packer, 'Reload Plugins' }
})

local toggle_onedark = function()
    require('onedark').toggle()
    print('current style =', vim.g.onedark_config.style)
end

add_group('toggle', '<space>t', {
    onedark_style = { 's', toggle_onedark, 'Toggle Onedark Style' }
})

add_group('git', '<space>g', {
    -- TODO
})
-- TODO map gitdiff

return M
