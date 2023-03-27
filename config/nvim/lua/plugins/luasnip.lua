return {
  'L3MON4D3/LuaSnip',
  version = 'v1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- build = 'make install_jsregexp',
  config = function()
    local ls = require('luasnip')
    ls.config.set_config {
      history = true,
      -- Update more often, :h events for more info.
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
    }

    -- extend html snippets to react files
    require('luasnip').filetype_extend('javascriptreact', { 'html' })
    require('luasnip').filetype_extend('typescriptreact', { 'html' })

    -- load snippets (friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
  event = 'VeryLazy',
}
