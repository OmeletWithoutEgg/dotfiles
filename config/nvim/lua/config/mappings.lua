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

local function add_group(group, leader, mappings)
    local mapping = { name = group }
    -- local short_cut = format_shortcut(leader .. keybind)
    for name, detail in pairs(mappings) do
        local keybind, rhs, desc = unpack(detail)
        local parsed = require('which-key.util').parse_keys(leader .. keybind)
        -- print(vim.inspect(parsed))
        mapping[keybind] = { rhs, desc }
        M[name] = {
            shortcut = join(parsed.notation),
            action = function()
                vim.fn.feedkeys(parsed.keys)
                -- TODO does this string really got captured?
            end,
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
    vim.cmd [[wall]]
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

-- local toggle_onedark = function()
--     require('onedark').toggle()
--     print('current style =', vim.g.onedark_config.style)
-- end
-- add_group('toggle', '<space>t', {
--     onedark_style = { 's', toggle_onedark, 'Toggle Onedark Style' }
-- })

add_group('git', '<space>g', {
    git_diffview             = { 'd', '<Cmd>DiffviewOpen<CR>', 'Open Git diffview' },
    git_diffview_toggle_file = { 't', '<Cmd>DiffviewToggleFiles<CR>', 'Diffview Toggle Files' },
    -- TODO
})
-- TODO map gitdiff

return M
