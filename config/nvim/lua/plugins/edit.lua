return {
  {
    'kylechui/nvim-surround',
    config = true,
  },
  -- {
  --   'smoka7/hop.nvim',
  --   version = '*',
  --   config = true,
  --   init = function()
  --     vim.keymap.set('n', '<space>j', '<Cmd>HopWord<CR>', {})
  --   end
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "<space>j", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "<space>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>",    mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      }
    },
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
