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

local lazy_opts = {
  ui = {
    border = 'single',
  }
}

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
  -- 'nvim-tree/nvim-web-devicons',

  -- [[ Edit ]]
  VeryLazy(require('plugins.edit')),

  --[[ Git ]]
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true,
    event = 'VeryLazy',
  },

  --[[ LSP & Completion & Tree-Sitter ]]
  require('plugins.mason-lspconfig'),
  require('plugins.nvim-cmp'),
  require('plugins.nvim-treesitter'),
  require('plugins.luasnip'),

  --[[ UI ]]
  require('plugins.ui.themes'),
  require('plugins.ui.alpha'),
  require('plugins.ui.nvim-tree'),
  require('plugins.ui.lualine'),

  'xiyaowong/transparent.nvim',
  -- 'ap/vim-css-color',
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    opts = { 'css', 'javascript', 'html', 'lua', 'rasi' },
    event = 'VeryLazy',
  },

  -- [[ Tool ]]
  require('plugins.tool.telescope'),
  require('plugins.tool.which-key'),

  {
    'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup {
        autoload_mode =
            require('session_manager.config').AutoloadMode.Disabled,
        autosave_last_session = false,
      }
    end,
    event = 'VeryLazy',
  },

  {
    'kevinhwang91/vim-ibus-sw',
    name = 'ibus-sw',
    config = true,
    event = 'VeryLazy',
  },
  'lambdalisue/suda.vim',

  --[[ Filetype Plugins ]]
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_url_maxsave = 0
      vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.wiki' } }
    end,
    event = 'VeryLazy',
  },

  VeryLazy {
    'kchmck/vim-coffee-script',
    'cespare/vim-toml',
    'itchyny/vim-haskell-indent',
    'pangloss/vim-javascript',
    'mxw/vim-jsx',
    'petRUShka/vim-sage',
    'isobit/vim-caddyfile',
    'posva/vim-vue',
    'digitaltoad/vim-pug',
    'Fymyte/rasi.vim',
  },

  -- [[ Misc ]]
  {
    'jbyuki/nabla.nvim',
    config = function()
      vim.cmd [[
        nnoremap <silent> <leader>p :lua require('nabla').popup()<CR>
        " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
      ]]
    end,
    event = 'VeryLazy',
  },

  -- 'jubnzv/mdeval.nvim',

}, lazy_opts)
