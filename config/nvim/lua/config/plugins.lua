return require('packer').startup(function(use)
  -- use 'wbthomason/packer.nvim' -- currently use yay to manage it

  --[[ Basic ]]
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  --[[ Edit ]]
  use {
      'lukas-reineke/indent-blankline.nvim',
      config = function() require('indent_blankline').setup {} end
  }
  -- use {
  --   'Yggdroot/indentLine',
  --   config = function()
  --     vim.g.indentLine_fileTypeExclude = { 'vimwiki', 'startify', 'alpha', 'lsp-installer', 'packer' }
  --     vim.g.indentLine_leadingSpaceEnabled = 0
  --     vim.g.indentLine_bufTypeExclude = { 'help', 'terminal', 'vimwiki' }
  --   end
  -- }
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {}
    end
  }
  use 'tommcdo/vim-lion'
  use 'tpope/vim-repeat'
  use 'editorconfig/editorconfig-vim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require 'hop'.setup {}
    end
  }
  use {
    'mfussenegger/nvim-treehopper',
  }

  --[[ Git ]]
  use 'sindrets/diffview.nvim'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup {} end
  }

  --[[ LSP & Completion & Tree-Sitter ]]
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer'
  }
  use 'hrsh7th/nvim-cmp'
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
  }

  -- use 'hrsh7th/cmp-omni',
  -- use 'ray-x/lsp_signature.nvim',
  use 'hrsh7th/vim-vsnip'
  use 'nvim-treesitter/nvim-treesitter'

  --[[ Appearance ]]
  use 'goolord/alpha-nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup {}
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
  }

  use 'hzchirs/vim-material'
  use {
    'kaicataldo/material.vim',
    'lifepillar/vim-solarized8',
    'cpea2506/one_monokai.nvim',
    'shaunsingh/nord.nvim',
    'navarasu/onedark.nvim',
    'Mofiqul/vscode.nvim',
  }
  use 'tribela/vim-transparent'

  use 'nvim-lualine/lualine.nvim'

  --[[ Nice Toolkit ]]
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
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
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        plugins = {
          marks = false,     -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        }
      }
    end
  }
  use 'kevinhwang91/vim-ibus-sw'
  use 'lambdalisue/suda.vim'

  --[[ Filetype Plugins ]]
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_url_maxsave = 0
      vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.wiki' } }
      vim.cmd [[
        autocmd FileType vimwiki setlocal nowrap concealcursor=
      ]]
    end
  }
  use 'Julian/lean.nvim'

  use {
    'kchmck/vim-coffee-script',
    'ap/vim-css-color',
    'cespare/vim-toml',
    'itchyny/vim-haskell-indent',
    'pangloss/vim-javascript',
    'mxw/vim-jsx',
    'petRUShka/vim-sage',
    'isobit/vim-caddyfile',
    'posva/vim-vue',
    'digitaltoad/vim-pug',
    'Fymyte/rasi.vim',
  }

  use {
    'jbyuki/nabla.nvim',
    config = function()
      vim.cmd [[
        nnoremap <silent> <leader>p :lua require("nabla").popup()<CR>
        " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
      ]]
    end
  }
end)
