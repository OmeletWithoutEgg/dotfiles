require('config.options')
require('config.plugins')
require('config.mappings')
require('config.lsp')
require('config.cmp')
require('config.treesitter')

require('config.lualine')
-- require('config.alpha')
require('config.alpha_startify')

local group = vim.api.nvim_create_augroup('CustomVimMaterial', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  pattern = 'vim-material',
  callback = function()
    vim.cmd [[
      hi Comment cterm=NONE gui=NONE |
      hi Search ctermfg=yellow guifg=yellow |
      hi CursorLine term=NONE cterm=NONE |
      hi CursorLineNr cterm=NONE
    ]]
  end
})

vim.cmd.colorscheme [[vim-material]]

vim.cmd [[
  function s:TeXFormat()
    setlocal foldmethod=marker
  endfunction
  augroup formattingHandler
    au!
    au FileType vue,c,cpp,html,markdown,vimwiki,tex,plaintex syntax sync fromstart
    au FileType tex,plaintex call <SID>TeXFormat()
  augroup END
]]
