-- [ options ] {{{
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
-- o.fillchars = 'eob: '

o.foldmethod = 'marker'
o.laststatus = 3 -- experimental?
-- }}}

-- [ lazy.nvim bootstrap ] {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup {
  spec = {
    { import = "plugins" },
    -- add your plugins here

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

    {
      'lervag/vimtex',
      init = function()
        vim.g.vimtex_view_method = 'zathura'
      end
    },

    -- TODO
    -- 'jbyuki/nabla.nvim',
    -- 'lukas-reineke/headlines.nvim',
    -- 'Julian/lean.nvim',
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },

  rocks = { hererocks = false },
  ui = {
    border = 'single',
  },
  performance = {
    rtp = {
      paths = { '~/.vim' }
    }
  }
}

vim.keymap.set('v', '>', '>gv', {})
vim.keymap.set('v', '<', '<gv', {})

vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]], {})
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]], {})

vim.keymap.set('n', '<C-G>', '1<C-G>', {})

vim.keymap.set('n', '<space>pp', '<Cmd>Lazy sync<CR>', {})
vim.keymap.set('n', '<space>ps', '<Cmd>Lazy<CR>', {}) -- status

vim.keymap.set('n', '<space>ac', '<Cmd>Telescope colorscheme<CR>', {})
vim.keymap.set('n', '<space>at', '<Cmd>TransparentToggle<CR>', {})

vim.cmd [[colorscheme gruvbox]]
-- vim.cmd [[colorscheme vim-material]]
