return require('packer').startup(function(use)
  -- use 'wbthomason/packer.nvim' -- use yay to manage it
  use 'Julian/lean.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-lua/plenary.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'hzchirs/vim-material'
  use 'kyazdani42/nvim-web-devicons'
  use 'tpope/vim-surround'
  use 'kyazdani42/nvim-tree.lua'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use 'rmagatti/goto-preview'

  use 'nvim-lua/lsp-status.nvim'
  use 'arkav/lualine-lsp-progress'

  use 'famiu/nvim-reload'
end)
