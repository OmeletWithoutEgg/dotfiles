return require('packer').startup(function(use)
    -- use 'wbthomason/packer.nvim' -- use yay to manage it
    use 'nvim-lua/plenary.nvim'
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer'
    }

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/cmp-omni'
    -- use {
    --     'ray-x/lsp_signature.nvim',
    -- }

    -- use 'hzchirs/vim-material'
    -- use 'projekt0n/github-nvim-theme'
    use 'navarasu/onedark.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    use 'nvim-lualine/lualine.nvim'
    use 'glepnir/dashboard-nvim'

    use 'tpope/vim-surround'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --         require('nvim-treesitter.install').update({ with_sync = true })
    --     end,
    -- }

    use 'vimwiki/vimwiki'
    use 'Julian/lean.nvim'
end)
