return {
  {
    'kylechui/nvim-surround',
    config = true,
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = true,
  },

  'tommcdo/vim-lion',
  'editorconfig/editorconfig-vim',
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
    config = true,
  },

  -- 'mbbill/undotree',
}
