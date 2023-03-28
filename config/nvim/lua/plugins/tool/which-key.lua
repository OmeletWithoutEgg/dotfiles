return {
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup {
      plugins = {
        marks = false,             -- shows a list of your marks on ' and `
        registers = false,         -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      }
    }
    require('config.mappings') -- TODO remove this
  end,
  event = 'VeryLazy',
}
