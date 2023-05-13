return {
  'mhinz/vim-startify',
  dependencies = {
    'lambdalisue/nerdfont.vim',
    'csch0/vim-startify-renderer-nerdfont',
    'lambdalisue/glyph-palette.vim',
  },
  init = function()
    vim.g.startify_bookmarks = { { c = '~/.config/nvim/init.lua' } }
    vim.g.startify_fortune_use_unicode = 1
  end,
  config = function()
    local function info_text()
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
    local header = vim.api.nvim_call_function('startify#fortune#boxed', {});
    table.insert(header, 1, info_text())
    local padded_header = vim.api.nvim_call_function('startify#pad', { header });
    vim.api.nvim_set_var('startify_custom_header', padded_header)
  end
}
