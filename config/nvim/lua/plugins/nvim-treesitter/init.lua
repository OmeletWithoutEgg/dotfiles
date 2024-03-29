local treesitter_opts = {
  -- A list of parser names, or 'all' (the four listed parsers should always be installed)
  ensure_installed = {
    'c', 'lua', 'vim', 'vimdoc',
    'dockerfile', 'make',
    'javascript',
    'cpp', 'rust',
    'latex',
    'python',
    'ruby',
    'haskell',
    'bash',
    'toml', 'yaml', 'html', 'css', 'rasi', 'scss',

    'markdown', 'markdown_inline',
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,
  -- incremental_selection = {
  --   enable = true
  -- },

  highlight = {
    enable = true,
    disable = { 'latex' },

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { 'c', 'rust' },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
      },
    },
  },

  autotag = {
    enable = true,
  },
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },
}

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'numToStr/Comment.nvim',
  },
  opts = treesitter_opts,
  config = function()
    require('nvim-treesitter.configs').setup(treesitter_opts)
    require('Comment').setup {
      pre_hook =
          require('ts_context_commentstring.integrations.comment_nvim')
          .create_pre_hook(),
    }
  end,
  init = function()
    vim.g.skip_ts_context_commentstring_module = true
  end,
  build = ':TSUpdate',
  event = 'VeryLazy',
}
