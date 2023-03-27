local colors = {
  bg       = 'NONE',
  -- fg       = '#bbc2cf',
  fg       = '#d5dbe5',
  cyan     = '#008080',
  darkblue = '#081633',
  orange   = '#ff8800',
  blue     = '#89ddff',
  -- green    = '#98be65',
  green    = '#8bd649',
  purple   = '#82aaff',
  -- yellow   = '#ecbe7b',
  yellow   = '#ffcc00',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  -- blue     = '#51afef',
  red      = '#ec5f67',
  black    = '#263238',
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
  buf_has_lsp = function()
    local buf_clients = vim.lsp.buf_get_clients()
    return #buf_clients ~= 0
  end
}

local function get_mode_color()
  -- auto change color according to neovims mode
  local mode_color = {
    n      = colors.green,
    no     = colors.blue,
    i      = colors.blue,
    ic     = colors.yellow,
    v      = colors.orange,
    V      = colors.orange,
    ['']  = colors.orange,
    c      = colors.red,
    s      = colors.blue,
    S      = colors.blue,
    ['']  = colors.blue,
    R      = colors.red,
    Rv     = colors.red,
    cv     = colors.red,
    ce     = colors.red,
    r      = colors.cyan,
    rm     = colors.cyan,
    ['r?'] = colors.cyan,
    ['!']  = colors.violet,
    t      = colors.violet,
  }
  return { bg = mode_color[vim.fn.mode()], fg = colors.darkblue, gui = 'bold' }
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
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  source = diff_source,
  cond = conditions.hide_in_width,
}

local lspstatus = {
  -- Lsp server name .
  function()
    -- local original_bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.buf_get_clients()
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
  cond = conditions.buf_has_lsp,
}

local diagnostics = {
  'diagnostics',
  -- sources = { 'nvim_diagnostic' },
  -- symbols = { error = '', warn = '', info = '' },
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
  component_separators = { left = '', right = '' },
  mode = 2,
  tabs_color = {
    active = { fg = colors.black, bg = colors.purple },
    inactive = { fg = colors.fg, bg = colors.bg },
  },
  fmt = function(name, context)
    -- Show + if buffer is modified in tab
    local buflist = vim.fn.tabpagebuflist(context.tabnr)
    local winnr = vim.fn.tabpagewinnr(context.tabnr)
    local bufnr = buflist[winnr]
    local mod = vim.fn.getbufvar(bufnr, '&mod')
    return name .. (mod == 1 and ' +' or '')
  end,
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('lualine').setup {
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
          },
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
        lualine_a = { mode },
        lualine_b = { filename },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { fileformat, fileencoding, filetype },
        lualine_z = { percent }
      },
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { tabs },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      -- extensions = { 'nvim-tree' },
    }
  end,
}
