return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local startify = require('alpha.themes.startify')

    local function info_text()
      ---@diagnostic disable-next-line:undefined-field
      local total_plugins = #vim.tbl_keys(require('lazy').plugins())
      local datetime = os.date '%Y-%m-%d %A'
      local version = vim.version()
      return string.format(
        [[Nvim v%d.%d.%d | %s | %d plugins <- lazy.nvim]],
        version.major, version.minor, version.patch,
        datetime,
        total_plugins
      )
    end

    startify.section.header.val = info_text

    local config = startify.config
    config.layout[3].val = 1
    require('alpha').setup(config)
  end
}
