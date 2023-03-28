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

map('v', '<', '<gv')
map('v', '>', '>gv')
-- map('v', 'J', [[<Cmd>m+1<CR>gv=gv]])
-- map('v', 'K', [[<Cmd>m-2<CR>gv=gv]])
map('n', '<C-g>', '1<C-g>')

add_group('telescope', '<space>f', {
  r = { '<Cmd>Telescope oldfiles<CR>', 'recent files' },
  f = { '<Cmd>Telescope find_files<CR>', 'files' },
  w = { '<Cmd>Telescope live_grep<CR>', 'live grep' },
  c = {
    '<Cmd>Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>',
    'config files'
  },
})

add_group('plugins', '<space>p', {
  p = { '<Cmd>Lazy sync<CR>', 'sync' },
  s = { '<Cmd>Lazy<CR>', 'status' },
})

add_group('vcs_diffview', '<space>vd', {
  o = { '<Cmd>DiffviewOpen<CR>', 'open' },
  t = { '<Cmd>DiffviewToggleFiles<CR>', 'toggle files' },
  c = { '<Cmd>DiffviewClose<CR>', 'close' }
})

add_group('vcs', '<space>v', {
  c = { '<Cmd>Telescope git_commits<CR>', 'git commits' },
  s = { '<Cmd>Telescope git_status<CR>', 'git status' }
})

add_group('nvim_tree', '<space>n', {
  t = { '<Cmd>NvimTreeToggle<CR>', 'toggle' }
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

add_group('session', '<space>s', {
  s = { '<Cmd>SessionManager save_current_session<CR>', 'save' },
  l = { '<Cmd>SessionManager load_session<CR>', 'load' },
  d = { '<Cmd>SessionManager delete_session<CR>', 'load' },
})

add_group('quickfix', '<space>c', {
  o = { '<Cmd>copen <CR>', 'open' },
  c = { '<Cmd>cclose <CR>', 'close' },
})

return M
