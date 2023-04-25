return {
  'neovim/nvim-lspconfig',
  config = function()
    require('plugins.lspconfig.config')
  end,
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    require('plugins.nvim-cmp'),
    -- 'folke/which-key.nvim',
    -- 'ray-x/lsp_signature.nvim',
  },
  event = 'VeryLazy',
}
