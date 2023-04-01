return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    'nvim-telescope/telescope-ui-select.nvim',
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local find_command = { 'fd', '--type', 'f', '--follow', }
    require('telescope').setup {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        oldfiles = {
          prompt_title = 'Recent Files',
          find_command = find_command
        },
        find_files = {
          find_command = find_command
        },
        live_grep = {
          find_command = find_command
        },
      }
    }
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('undo')
  end,
  event = 'VeryLazy',
}
