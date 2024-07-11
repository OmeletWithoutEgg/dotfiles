-- [ Options ] {{{
local o = vim.opt

o.termguicolors = true

o.guicursor = ''
o.number = true
o.relativenumber = true
o.cindent = true
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.hlsearch = true

o.mouse = 'nvh'
o.cinoptions = 'j1'
o.cursorline = true
o.showmode = false
o.lazyredraw = true
o.autochdir = true
o.showcmd = true
o.ttimeoutlen = 0

o.signcolumn = 'yes:1'

o.ruler = false
o.fillchars = 'eob: '

o.foldmethod = 'marker'
o.laststatus = 3 -- experimental?
-- }}}

-- [ Keymaps ] {{{
local keymap_groups = {}

vim.g.mapleader = '\\'

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function add_keymap_group(group, leader, mappings)
  local function snake_style(s)
    return string.gsub(s, ' ', '_')
  end
  for keybind, detail in pairs(mappings) do
    local rhs, desc = unpack(detail)
    desc = group .. '.' .. snake_style(desc)
    map('n', leader .. keybind, rhs, { desc = desc })
  end
  keymap_groups[leader] = group
end

map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', 'J', [[:m '>+1<CR>gv=gv]])
map('v', 'K', [[:m '<-2<CR>gv=gv]])
map('n', '<C-g>', '1<C-g>')

map('n', '<space>e', '<Cmd>Fern . -drawer -toggle<CR>', { desc = 'fern.toggle' })
map('n', '<space>j', '<Cmd>HopWord<CR>', { desc = 'hop' })

local function telescope_project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

add_keymap_group('telescope', '<space>f', {
  r = { '<Cmd>Telescope oldfiles<CR>', 'recent files' },
  f = { telescope_project_files, 'files' },
  w = { '<Cmd>Telescope live_grep<CR>', 'live grep' },
  c = {
    '<Cmd>Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '<CR>',
    'config files'
  },
})

add_keymap_group('plugins', '<space>p', {
  p = { '<Cmd>Lazy sync<CR>', 'sync' },
  s = { '<Cmd>Lazy<CR>', 'status' },
})

add_keymap_group('vcs', '<space>v', {
  c = { '<Cmd>Telescope git_commits<CR>', 'git commits' },
  s = { '<Cmd>Telescope git_status<CR>', 'git status' }
})

add_keymap_group('treesitter', '<space>t', {
  t = { '<Cmd>TSUpdate<CR>', 'update' },
  h = { '<Cmd>TSToggle highlight<CR>', 'toggle highlight' },
})

add_keymap_group('appearance', '<space>a', {
  c = { '<Cmd>Telescope colorscheme<CR>', 'colorschemes' },
  t = { '<Cmd>TransparentToggle<CR>', 'toggle transparent' },
})
-- }}}

-- [ Plugins ] {{{
-- [[ lazy.nvim basic setup ]] {{{
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyopts = {
  ui = {
    border = 'single',
  },
  performance = {
    rtp = {
      paths = { '~/.vim' }
    }
  }
}
-- }}}

local function VeryLazy(plugins)
  --- WARN: this function does not go deep
  for key, plugin in pairs(plugins) do
    if type(plugin) == 'string' then
      plugins[key] = { plugin, event = 'VeryLazy' }
    else
      plugins[key].event = 'VeryLazy'
    end
  end
  return plugins
end

require('lazy').setup({
  'nvim-lua/plenary.nvim',

  require('plugins.nvim-treesitter'),
  require('plugins.lspconfig'),
  -- require('plugins.nvim-cmp'),

  -- [[ Edit ]] {{{
  VeryLazy {
    {
      'kylechui/nvim-surround',
      config = true,
    },
    {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = true,
    },
    'tommcdo/vim-lion',
    -- 'editorconfig/editorconfig-vim', -- nvim 0.9 has builtin support
    {
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl',
      opts = {
        exclude = {
          filetypes = { 'startify' }
        }
      },
    },
  },
  -- }}}

  -- [[ Git ]] {{{
  VeryLazy {
    'sindrets/diffview.nvim',
    {
      'lewis6991/gitsigns.nvim',
      config = true,
    },
  },
  -- }}}

  -- [[ UI ]] {{{
  require('plugins.ui.lualine'),
  require('plugins.ui.startify'),

  -- [[[ glyph-palette.vim & fern.vim ]]] {{{
  {
    'lambdalisue/glyph-palette.vim',
    config = function()
      local group = vim.api.nvim_create_augroup('ApplyPalette', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'fern,startify',
        callback = function()
          vim.api.nvim_call_function('glyph_palette#apply', {})
        end
      })
    end,
  },
  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-git-status.vim',
      'lambdalisue/fern-hijack.vim',
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/nerdfont.vim',
    },
    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
    end,
  },
  -- }}}

  -- [[[ themes collection ]]] {{{
  {
    'hzchirs/vim-material',
    VeryLazy {
      { 'catppuccin/nvim', name = 'catppuccin', },
      'sainnhe/sonokai',
      'Mofiqul/dracula.nvim',
      'Shatur/neovim-ayu',
      'kaicataldo/material.vim',
      'lifepillar/vim-solarized8',
      'cpea2506/one_monokai.nvim',
      'shaunsingh/nord.nvim',
      'navarasu/onedark.nvim',
      'Mofiqul/vscode.nvim',
      'folke/tokyonight.nvim',
      'morhetz/gruvbox',
      'AlexvZyl/nordic.nvim',
    },
  },
  -- }}}

  'xiyaowong/transparent.nvim',
  -- 'ap/vim-css-color',
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    opts = { 'css', 'javascript', 'html', 'lua', 'rasi' },
    event = 'VeryLazy',
  },
  --- }}}


  -- [[ Tool ]]
  -- [[[ telescope.nvim ]]] {{{
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      local find_command = { 'fd', '--type', 'f', '--follow', }
      require('telescope').setup {
        defaults = {
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
        },
        pickers = {
          oldfiles = {
            prompt_title = 'Recent Files',
            find_command = find_command
          },
          find_files = {
            find_command = find_command
          },
          live_grep = {
            find_command = find_command
          },
        }
      }
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('undo')
    end,
    event = 'VeryLazy',
  },
  -- }}}
  -- [[[ which-key.nvim ]]] {{{
  {
    'folke/which-key.nvim',
    config = function()
      local wk = require('which-key')
      wk.setup {
        plugins = {
          marks = false,     -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        }
      }
      for leader, group in pairs(keymap_groups) do
        local mapping = { name = group }
        wk.register { [leader] = mapping }
      end
    end,
    event = 'VeryLazy',
  },
  -- }}}

  VeryLazy {
    -- {
    --   'kevinhwang91/vim-ibus-sw',
    --   name = 'ibus-sw',
    --   config = true,
    -- },
    'lambdalisue/suda.vim',
  },

  -- [[ Filetype Plugins ]] {{{
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_markdown_link_ext = 1
      vim.g.vimwiki_url_maxsave = 0
      vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.md' } }
      -- vim.g.vimwiki_folding = 'expr'
    end,
  },

  VeryLazy {
    'kchmck/vim-coffee-script',
    'cespare/vim-toml',
    'itchyny/vim-haskell-indent',
    'pangloss/vim-javascript',
    'mxw/vim-jsx',
    'petRUShka/vim-sage',
    'isobit/vim-caddyfile',
    -- 'posva/vim-vue',
    'digitaltoad/vim-pug',
    'Fymyte/rasi.vim',
    {
      'preservim/vim-markdown',
      init = function()
        vim.g.vim_markdown_folding_disabled = 1
        -- vim.g.vim_markdown_no_default_key_mappings = 1
        vim.g.vim_markdown_conceal = 0
        vim.g.vim_markdown_conceal_code_blocks = 0
        -- vim.g. g:vim_markdown_toml_frontmatter = 1
        vim.g.vim_markdown_frontmatter = 1 -- YAML
        vim.g.vim_markdown_math = 1
      end
    },
  },
  -- }}}

  -- [[ Misc ]]
  -- [[[ nvim-ufo ]]] {{{
  {
    -- https://github.com/neovim/neovim/pull/12515
    -- https://github.com/neovim/neovim/issues/12649
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    init = function()
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require('ufo').setup {
        open_fold_hl_timeout = 1,
      }
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    end,
    event = 'VeryLazy'
  },
  -- }}}

  {
    'jbyuki/nabla.nvim',
    config = function()
      map('n', '<leader>p', [[<Cmd>lua require('nabla').popup()<CR>]])
      -- Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
    end,
    event = 'VeryLazy',
  },
  -- 'jubnzv/mdeval.nvim',
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true, -- or `opts = {}`
  },

  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      -- you also will likely want nvim-cmp or some completion engine
    },
    -- see details below for full configuration options
    opts = {
      lsp = {
        on_attach = require('plugins.lspconfig').opts.on_attach,
      },
      mappings = true,
    }
  },

  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end
  },

  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_filetypes = {
        ['*'] = false,
        lua = true,
        python = true,
      }

      -- map('i', '<C-X><C-P>', '<Plug>(copilot-previous)')
      -- map('i', '<C-X><C-N>', '<Plug>(copilot-next)')
    end
  },

  { 'folke/zen-mode.nvim' },

  -- https://www.reddit.com/r/agda/comments/15h2pwu/isovectorcornelis_agdamode_for_neovim/
  {
    "isovector/cornelis",
    ft = { "agda" },
    build = "stack build",
    dependencies = {
      "kana/vim-textobj-user",
      "neovimhaskell/nvim-hs.vim",
      "folke/which-key.nvim",
    },

    init = function()
      local leader = ' c'
      local agda_filetype = function()
        local mappings = {
          { leader .. 'xr', ':CornelisRestart<CR>' },
          { leader .. 'l',  ':CornelisLoad<CR>:CornelisQuestionToMeta<CR>' },
          { leader .. 'r',  ':CornelisRefine<CR>' },
          { leader .. 'c',  ':CornelisMakeCase<CR>' },
          { leader .. ',',  ':CornelisTypeContext<CR>' },
          { leader .. 'd',  ':CornelisTypeInfer<CR>' },
          { leader .. '.',  ':CornelisTypeContextInfer<CR>' },
          { leader .. 's',  ':CornelisSolve<CR>' },
          { leader .. 'a',  ':CornelisAuto<CR>' },
          { leader .. 'b',  ':CornelisPrevGoal<CR>' },
          { leader .. 'f',  ':CornelisNextGoal<CR>' },
          { 'gd',           ':CornelisGoToDefinition<CR>' },
        }
        for _, mapping in ipairs(mappings) do
          local lhs, rhs = unpack(mapping)
          map('n', lhs, rhs, { buffer = true })
          -- TODO map in insert mode?
        end
      end

      local group = vim.api.nvim_create_augroup('AgdaMapping', {})
      local pattern = { '*.agda', '*.agda.md', '*.lagda.md' }
      local opts = {
        group = group,
        pattern = pattern,
        callback = agda_filetype
      }
      vim.api.nvim_create_autocmd('BufRead', opts)
      vim.api.nvim_create_autocmd('BufNewFile', opts)
      -- au BufRead,BufNewFile *.agda,*agda.md call AgdaFiletype()
      -- " au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>"

      local wk = require('which-key')
      wk.register { [leader] = { name = 'Cornelis' } }
      vim.g.cornelis_split_location = 'bottom'
      -- vim.g.cornelis_max_size = 40
    end,
  },

}, lazyopts);

-- }}}

local group = vim.api.nvim_create_augroup('CustomVimMaterial', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  pattern = 'vim-material',
  callback = function()
    local function hi(name, opts)
      local options = vim.api.nvim_get_hl(0, { name = name })
      options = vim.tbl_extend('force', options, opts)
      vim.api.nvim_set_hl(0, name, options)
    end

    hi('Comment', { italic = false })
    hi('Search', { fg = 'yellow' })

    hi('GlyphPalette1', { fg = '#FF5370' }) -- red
    hi('GlyphPalette2', { fg = '#C3E88D' }) -- green
    hi('GlyphPalette3', { fg = '#FFCB6B' }) -- yellow
    hi('GlyphPalette4', { fg = '#89DDFF' }) -- blue
    -- hi('GlyphPalette5') -- magenta
    hi('GlyphPalette6', { fg = '#82AAFF' }) -- cyan/purple
    hi('GlyphPalette7', { fg = '#FFFFFF' }) -- white
    -- tips: :call glyph_palette#tools#show_palette()
    -- tips: :Inspect to find hlgroup under cursor

    hi('Underlined', { fg = '#80a0ff' })
  end
})

vim.o.background = 'dark'
vim.cmd.colorscheme [[vim-material]]

vim.g.gcc_compile_flag =
    '-g -Dlocal -Ofast ' ..
    '-Wall -Wextra -Wshadow -Wconversion -Wfatal-errors ' ..
    '-fsanitize=undefined,address'
