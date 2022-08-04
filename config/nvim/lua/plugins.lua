return require('packer').startup(function(use)
  -- use 'wbthomason/packer.nvim' -- use yay to manage itself
  use 'Julian/lean.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'hzchirs/vim-material'
  use "kyazdani42/nvim-web-devicons"
  use 'tpope/vim-surround'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
end)
