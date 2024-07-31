return {
  -- [[[ themes collection ]]] {{{
  {
    'hzchirs/vim-material',
    'sainnhe/gruvbox-material',
    { 'catppuccin/nvim', name = 'catppuccin', },
    {
      'sainnhe/sonokai',
      'Mofiqul/dracula.nvim',
      'Shatur/neovim-ayu',
      'kaicataldo/material.vim',
      'lifepillar/vim-solarized8',
      'cpea2506/one_monokai.nvim',
      'shaunsingh/nord.nvim',
      'navarasu/onedark.nvim',
      'Mofiqul/vscode.nvim',
      'folke/tokyonight.nvim',
      'ellisonleao/gruvbox.nvim',
      'AlexvZyl/nordic.nvim',
    },
  },
  -- }}}

  -- [[[ glyph-palette.vim & fern.vim ]]] {{{
  {
    'lambdalisue/glyph-palette.vim',
    config = function()
      local group = vim.api.nvim_create_augroup('ApplyPalette', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'fern,startify',
        callback = function()
          vim.api.nvim_call_function('glyph_palette#apply', {})
        end
      })
    end,
  },
  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-git-status.vim',
      'lambdalisue/fern-hijack.vim',
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/nerdfont.vim',
    },
    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.cmd [[
        augroup FernCustom
          autocmd!
          autocmd FileType fern setlocal nonumber norelativenumber
        augroup END
        nnoremap <space>e <Cmd>Fern . -drawer -toggle<CR>
      ]]
    end,
  },
  -- }}}

  -- -- [[ startify ]] {{{
  -- {
  --   'mhinz/vim-startify',
  --   dependencies = {
  --     'lambdalisue/nerdfont.vim',
  --     'csch0/vim-startify-renderer-nerdfont',
  --     'lambdalisue/glyph-palette.vim',
  --   },
  --   init = function()
  --     vim.g.startify_bookmarks = { { c = '~/.config/nvim/init.lua' } }
  --     vim.g.startify_fortune_use_unicode = 1
  --   end,
  --   config = function()
  --     local function info_text()
  --       local total_plugins = #vim.tbl_keys(require('lazy').plugins())
  --       local datetime = os.date '%Y-%m-%d %A'
  --       local version = vim.version()
  --       return string.format(
  --       [[Nvim v%d.%d.%d | %s | %d plugins <- lazy.nvim]],
  --       version.major, version.minor, version.patch,
  --       datetime,
  --       total_plugins
  --       )
  --     end
  --     local header = vim.api.nvim_call_function('startify#fortune#boxed', {});
  --     table.insert(header, 1, info_text())
  --     local padded_header = vim.api.nvim_call_function('startify#pad', { header });
  --     vim.api.nvim_set_var('startify_custom_header', padded_header)
  --   end
  -- },
  -- -- }}}

  {
    'echasnovski/mini.statusline',
    version = false,
    opts = { set_vim_settings = false },
  },

  {
    'echasnovski/mini.starter',
    version = false,
    config = function()
      local function info_text()
        local total_plugins = #vim.tbl_keys(require('lazy').plugins())
        local datetime = os.date '%Y-%m-%d %a %k:%M'
        local version = vim.version()
        return string.format(
          [[Nvim v%d.%d.%d | %d plugins <- lazy.nvim]] .. '\n' ..
          [[%s]],
          version.major, version.minor, version.patch, total_plugins,
          datetime
        )
      end
      local starter = require('mini.starter')
      starter.setup {
        header = info_text,
        -- TODO change footer to a function
      }
    end
  },

  'xiyaowong/transparent.nvim',
  -- 'ap/vim-css-color',
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    opts = { 'css', 'javascript', 'html', 'lua', 'rasi' },
    event = 'VeryLazy',
  },
}
