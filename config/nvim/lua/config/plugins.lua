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

require('lazy').setup({
  {
    'nvim-tree/nvim-web-devicons',
  },
  --[[ Edit ]]
  'lukas-reineke/indent-blankline.nvim',
  {
    'kylechui/nvim-surround',
    config = true,
  },
  'tommcdo/vim-lion',
  -- 'tpope/vim-repeat',
  'editorconfig/editorconfig-vim',
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup {
        pre_hook =
            require('ts_context_commentstring.integrations.comment_nvim')
            .create_pre_hook(),
      }
    end
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = true,
  },

  'mbbill/undotree',

  --[[ Git ]]
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  --[[ LSP & Completion & Tree-Sitter ]]
  {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer'
  },
  'hrsh7th/nvim-cmp',
  {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
  },

  -- 'hrsh7th/cmp-omni',
  -- 'ray-x/lsp_signature.nvim',
  'hrsh7th/vim-vsnip',
  'nvim-treesitter/nvim-treesitter',

  --[[ Appearance ]]
  require('config.alpha_startify'),

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('nvim-tree').setup {
        respect_buf_cwd = true
      }
      vim.cmd [[
        function s:opendir()
          if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
            execute 'cd ' .. argv()[0]
            NvimTreeOpen
          endif
        endfunction
        augroup nvimtreeOpenDirectory
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * call <SID>opendir()
        augroup END
      ]]
    end
  },

  'hzchirs/vim-material',
  {
    'kaicataldo/material.vim',
    'lifepillar/vim-solarized8',
    'cpea2506/one_monokai.nvim',
    'shaunsingh/nord.nvim',
    'navarasu/onedark.nvim',
    'Mofiqul/vscode.nvim',
  },

  'xiyaowong/transparent.nvim',

  require('config.lualine'),

  -- 'ap/vim-css-color',
  {
    'norcalli/nvim-colorizer.lua',
    opts = { 'css', 'javascript', 'html', 'lua', 'rasi' },
    config = true,
  },

  --[[ Nice Toolkit ]]
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    config = function()
      local find_command = { 'fd', '--type', 'f' }
      require('telescope').setup {
        defaults = {
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
        },
        pickers = {
          oldfiles = { find_command = find_command },
          find_files = { find_command = find_command },
          live_grep = { find_command = find_command },
        }
      }
      require('telescope').load_extension('fzf')
    end
  },

  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        plugins = {
          marks = false,     -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        }
      }
    end
  },

  {
    'kevinhwang91/vim-ibus-sw',
    config = function()
      require('ibus-sw').setup()
    end
  },
  'lambdalisue/suda.vim',

  --[[ Filetype Plugins ]]
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_url_maxsave = 0
      vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.wiki' } }
      vim.cmd [[
        autocmd FileType vimwiki setlocal nowrap concealcursor=
      ]]
    end
  },

  {
    'Julian/lean.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },

  {
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

  {
    'jbyuki/nabla.nvim',
    config = function()
      vim.cmd [[
        nnoremap <silent> <leader>p :lua require('nabla').popup()<CR>
        " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
      ]]
    end
  },

  {
    'lifepillar/vim-colortemplate'
  },
}, lazy_opts)
