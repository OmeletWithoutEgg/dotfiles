return {
  {
    'kylechui/nvim-surround',
    config = true,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = true,
    init = function()
      vim.keymap.set('n', '<space>j', '<Cmd>HopWord<CR>', {})
    end
  },

  'tommcdo/vim-lion',
  -- 'editorconfig/editorconfig-vim', -- nvim 0.9 has builtin support
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      exclude = {
        filetypes = { 'startify' }
      }
    },
  },

  -- https://www.reddit.com/r/neovim/comments/1bwlvrt/neovim_now_has_builtin_commenting/
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
}
