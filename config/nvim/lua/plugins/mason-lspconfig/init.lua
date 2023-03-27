return {
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('plugins.mason-lspconfig.config')
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'folke/which-key.nvim',
      -- 'ray-x/lsp_signature.nvim',
    },
  },
}
