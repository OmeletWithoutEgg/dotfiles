return require('packer').startup(function(use)
    -- use 'wbthomason/packer.nvim' -- currently use yay to manage it

    --[[ Basic ]]
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'

    --[[ Edit ]]
    -- use {
    --     'lukas-reineke/indent-blankline.nvim',
    --     config = function() require('indent_blankline').setup {} end
    -- }
    use {
        'Yggdroot/indentLine',
        config = function()
            vim.g.indentLine_fileTypeExclude = { 'vimwiki', 'alpha', 'lsp-installer', 'packer' }
            vim.g.indentLine_leadingSpaceEnabled = 0
            vim.g.indentLine_bufTypeExclude = { 'help', 'terminal', 'vimwiki' }
        end
    }
    use 'tpope/vim-surround'
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
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
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
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-vsnip'

    -- use 'hrsh7th/cmp-omni',
    -- use 'ray-x/lsp_signature.nvim',
    use 'hrsh7th/vim-vsnip'
    use {
        'nvim-treesitter/nvim-treesitter',
    }

    --[[ Appearance ]]
    use 'goolord/alpha-nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          require('nvim-tree').setup {}
          vim.cmd[[
            autocmd StdinReadPre * let s:std_in=1
            autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'cd ' .. argv()[0] | NvimTreeOpen | endif
          ]]
        end
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
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
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
            require('telescope').load_extension('fzf')
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
    use 'kevinhwang91/vim-ibus-sw'

    -- use 'gw31415/deepl.vim'
    -- use {
    --     'gw31415/deepl-commands.nvim',
    --     -- cmd = { 'DeepL', 'DeepLTarget' },
    --     config = function()
    --         require('deepl-commmands').setup {
    --             -- selector_func = require 'fzyselect'.start, -- default value is `vim.ui.select`
    --             -- default_target = 'JA', -- Default value is 'EN'
    --         }
    --     end
    -- }

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
    use {
        'bfredl/nvim-luadev',
        config = function()
            vim.cmd [[
            nmap <leader>ll <Plug>(Luadev-RunLine)
            nmap <leader>lr <Plug>(Luadev-Run)
            nmap <leader>lw <Plug>(Luadev-RunWord)
            nmap <leader>lc <Plug>(Luadev-Complete)
            ]]
        end
    }

    use 'kchmck/vim-coffee-script'
    use 'ap/vim-css-color'
    use 'cespare/vim-toml' -- TOML syntax highlight
    use 'itchyny/vim-haskell-indent'
    use 'pangloss/vim-javascript'
    use 'mxw/vim-jsx'
    use 'petRUShka/vim-sage'
    use 'isobit/vim-caddyfile'
    use 'posva/vim-vue'
    use 'digitaltoad/vim-pug'
end)
