return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'lua', 'vim', 'vimdoc',
        'dockerfile', 'make',
        'c', 'cpp', 'rust', 'javascript',
        'python', 'ruby', 'bash',
        'latex', 'haskell',
        'toml', 'yaml', 'html', 'css', 'rasi', 'scss',
        'markdown', 'markdown_inline',
      },
      highlight = {
        enable = true,
        disable = { 'latex' },
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
            ['as'] = {
              query = '@scope',
              query_group = 'locals',
              desc = 'Select language scope'
            },
          },
        },
      },
    }
  end,
  lazy = false,
  branch = 'master', -- TODO change to main when it's stable enough(?)
  version = '*', -- https://www.reddit.com/r/neovim/comments/1bhpf5r/treesitter_invalid_node_type_modeline/
}
