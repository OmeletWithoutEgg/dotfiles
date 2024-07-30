return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
        {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'debugloop/telescope-undo.nvim',

},

  config = function()
    local telescope = require('telescope')
    telescope.setup {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        oldfiles = {
          prompt_title = 'Recent Files',
        }
      }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('undo')



    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<space>fr', builtin.oldfiles, {})
    vim.keymap.set('n', '<space>ff', builtin.find_files, {})
    vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<space>fb', builtin.buffers, {})
    vim.keymap.set('n', '<space>fh', builtin.help_tags, {})

    vim.keymap.set('n', '<space>fc', function()
      return builtin.find_files { cwd = vim.fn.stdpath('config') }
    end, {})
  end
}
