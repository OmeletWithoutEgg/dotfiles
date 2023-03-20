local startify = require'alpha.themes.startify'

local function info_text()
  ---@diagnostic disable-next-line:undefined-field
  local total_plugins = #vim.tbl_keys(_G.packer_plugins)
  local datetime = os.date '%Y-%m-%d %A'
  local version = vim.version()
  local nvim_version_info = 'Nvim v' .. version.major .. '.' .. version.minor .. '.' .. version.patch

  return nvim_version_info .. ' | ' .. datetime .. ' | ' .. total_plugins .. ' plugins'
end

startify.section.header.val = info_text

local config = startify.config

config.layout[3].val = 1

require('alpha').setup(config)
