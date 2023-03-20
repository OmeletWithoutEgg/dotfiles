-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = 'NONE',
  -- bg       = '#263238',
  fg       = '#bbc2cf',
  yellow   = '#ecbe7b',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#ff8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function get_mode_color()
  -- auto change color according to neovims mode
  local mode_color = {
    n       = colors.blue,   -- colors.red,
    i       = colors.red,    -- colors.green,
    v       = colors.orange, -- colors.blue,
    ['']  = colors.orange, -- colors.blue,
    V       = colors.orange, -- colors.blue,
    c       = colors.red,    -- colors.magenta,
    no      = colors.blue,   -- colors.red,
    s       = colors.orange,
    S       = colors.orange,
    ['']  = colors.orange,
    ic      = colors.yellow,
    R       = colors.violet,
    Rv      = colors.violet,
    cv      = colors.red,
    ce      = colors.red,
    r       = colors.cyan,
    rm      = colors.cyan,
    ['r?']  = colors.cyan,
    ['!']   = colors.red, -- ???
    t       = colors.red, -- ???
  }
  return { bg = mode_color[vim.fn.mode()], fg = '#263238', gui = 'bold' }
end

local mode = {
  function()
    local mode = require('lualine.utils.mode').get_mode()
    return ' ' .. mode
  end,
}

local paste = {
  function()
    return 'PASTE'
  end,
  cond = function()
    return vim.o.paste
  end,
}

-- 'readonly': '%R'

local filename = {
  'filename',
  cond = conditions.buffer_not_empty,
  -- color = { fg = colors.magenta, gui = 'bold' },
}

local branch = {
  'branch',
  color = { fg = colors.green },
}

-- https://github.com/nvim-lualine/lualine.nvim/issues/799#issuecomment-1214269869
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local diff = {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  source = diff_source,
  -- cond = conditions.hide_in_width,
}

local lspstatus = {
  -- Lsp server name .
  function()
    local original_bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_active_clients { bufnr = original_bufnr }
    local result = nil
    for _, client in pairs(buf_clients) do
      if result == nil then
        result = client.name
      else
        result = result .. ', ' .. client.name
      end
    end
    return result
  end,
  icon = ' ',
  cond = function()
    local clients = vim.lsp.get_active_clients()
    return #clients ~= 0
  end,
}

local diagnostics = {
  'diagnostics',
  -- sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
  alwas_visible = true,
}

local filetype = {
  'filetype',
  icons_enabled = false,
}

local fileencoding = {
  'o:encoding', -- option component same as &encoding in viml
  cond = conditions.hide_in_width,
}

local fileformat = {
  'fileformat',
  icons_enabled = false,
}

local percent = {
  '%3p%%',
}

local location = {
  'location',
}

local tabs = {
  'tabs',
  max_length = vim.o.columns,
  mode = 2,
  tabs_color = {
    active = { fg = '#263238', bg = colors.blue },
    inactive = { fg = colors.fg, bg = colors.bg },
  },
}

local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '|',
    section_separators = '',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    theme = {
      normal = {
        a = get_mode_color,
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        x = { fg = '#ffffff', bg = colors.bg, gui = 'bold' },
        z = get_mode_color,
      }
    },
  },
  sections = {
    lualine_a = { mode, paste },
    lualine_b = { filename, branch, diff },
    lualine_c = {},
    lualine_x = { diagnostics, lspstatus },
    lualine_y = { fileformat, fileencoding, filetype },
    lualine_z = { percent, location }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { filename },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { percent },
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { tabs },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
