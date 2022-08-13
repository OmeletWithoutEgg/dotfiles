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
    use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/cmp-omni'
    -- use {
    --     'ray-x/lsp_signature.nvim',
    -- }

    -- use 'hzchirs/vim-material'
    -- use 'projekt0n/github-nvim-theme'
    use {
        'navarasu/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup { style = 'dark' }
            onedark.load()
        end
    }
    use 'kyazdani42/nvim-web-devicons'
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup()
        end
    }
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    use 'nvim-lualine/lualine.nvim'
    use 'glepnir/dashboard-nvim'

    use 'tpope/vim-surround'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        config = function()
            -- require('telescope').load_extension('media_files')
            local find_command = { 'rg', '--hidden', '--files' }
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
        end
    }

    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {
                plugins = {
                    marks = false, -- shows a list of your marks on ' and `
                    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                }
            }
        end
    }

    use 'tommcdo/vim-lion'

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --         require('nvim-treesitter.install').update({ with_sync = true })
    --     end,
    -- }

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
end)
