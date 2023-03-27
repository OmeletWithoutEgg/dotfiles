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
  },
  config = function()
    local find_command = { 'fd', '--type', 'f' }
    require('telescope').setup {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        oldfiles = { find_command = find_command },
        find_files = { find_command = find_command },
        live_grep = { find_command = find_command },
      }
    }
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
  end
}
