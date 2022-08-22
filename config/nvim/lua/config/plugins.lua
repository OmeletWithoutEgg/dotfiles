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
    use 'tpope/vim-surround'
    use 'tommcdo/vim-lion'
    use 'tpope/vim-repeat'
    use 'editorconfig/editorconfig-vim'
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup {} end
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
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- 'hrsh7th/cmp-omni',
        -- 'ray-x/lsp_signature.nvim',
    }
    use 'hrsh7th/vim-vsnip'
    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --         require('nvim-treesitter.install').update({ with_sync = true })
    --     end,
    -- }

    --[[ Appearance ]]
    use 'glepnir/dashboard-nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('nvim-tree').setup {} end
    }

    use 'kaicataldo/material.vim'
    use 'hzchirs/vim-material'
    use 'lifepillar/vim-solarized8'
    use 'cpea2506/one_monokai.nvim'
    use 'shaunsingh/nord.nvim'
    use {
        'navarasu/onedark.nvim',
        config = function()
            -- require('onedark').setup {
            --     style = 'warm',
            --     -- toggle_style_key = '<Plug>(onedark-toggle-style)',
            --     code_style = { comments = 'none' },
            -- }
            -- require('onedark').load()
        end
    }
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    use 'nvim-lualine/lualine.nvim'
    -- use {
    --     'romgrk/barbar.nvim',
    --     config = function() require('bufferline').setup {} end
    -- }

    --[[ Nice Toolkit ]]
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

    --[[ Misc ]]
    -- use 'edluffy/hologram.nvim'
    -- use '~/Repos/hologram.nvim'
    -- use {
    --     'bfredl/nvim-luadev',
    --     config = function()
    --         vim.cmd [[
    --             nmap <leader>ll <Plug>(Luadev-RunLine)
    --             nmap <leader>lr <Plug>(Luadev-Run)
    --             nmap <leader>lw <Plug>(Luadev-RunWord)
    --             nmap <leader>lc <Plug>(Luadev-Complete)
    --         ]]
    --     end
    -- }
end)
