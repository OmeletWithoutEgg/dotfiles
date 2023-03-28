require('config.options')
require('plugins')

local group = vim.api.nvim_create_augroup('CustomVimMaterial', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  pattern = 'vim-material',
  callback = function()
    vim.cmd [[
      hi Comment cterm=NONE gui=NONE
      hi Search ctermfg=yellow guifg=yellow
      hi CursorLine term=NONE cterm=NONE
      hi CursorLineNr cterm=NONE
      hi TabLineFill gui=NONE " prevent lualine flash
      hi TabLineSel gui=NONE " prevent lualine flash
      hi TabLine gui=NONE " prevent lualine flash
    ]]
  end
})

vim.o.background = 'dark'
vim.cmd.colorscheme [[vim-material]]

vim.cmd(
  string.format(
    [[source %s/buf.vim]],
    vim.fn.stdpath('config')
  )
)

-- vim.cmd [[
--   function s:TeXFormat()
--     setlocal foldmethod=marker
--   endfunction
--   augroup formattingHandler
--     au!
--     au FileType vue,c,cpp,html,markdown,vimwiki,tex,plaintex syntax sync fromstart
--     au FileType tex,plaintex call <SID>TeXFormat()
--   augroup END
-- ]]
