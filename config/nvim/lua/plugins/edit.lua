return {
  {
    'kylechui/nvim-surround',
    config = true,
  },

  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup {
        pre_hook =
            require('ts_context_commentstring.integrations.comment_nvim')
            .create_pre_hook(),
      }
    end,
    event = 'VeryLazy',
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = true,
  },

  'tommcdo/vim-lion',
  'editorconfig/editorconfig-vim',
  'lukas-reineke/indent-blankline.nvim',
  'mbbill/undotree',
}
