-- Always show sign column.
-- The sign column is used by the LSP support to show diagnostics
-- (the E, W, etc. characters on the side)
-- as well as by the Lean plugin to show the orange bars.
-- By default the sign column is only shown if there are signs to show,
-- which means the buffer will constantly jump right and left.
vim.opt.signcolumn = "yes:1"

-- Enable nvim-cmp, with 3 completion sources, including LSP
-- local cmp = require'cmp'
-- cmp.setup{
--     mapping = cmp.mapping.preset.insert({
--       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-Space>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.abort(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     }),
--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       { name = 'path' },
--       { name = 'buffer' },
--     })
-- }


local function preview_location_callback(_, result, _)
  if result == nil or vim.tbl_isempty(result) then
    vim.notify('No definition found.')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-- You may want to reference the nvim-cmp documentation for further
-- configuration of completion: https://github.com/hrsh7th/nvim-cmp#recommended-configuration

-- Configure the language server:

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  vim.keymap.set('n', '<leader>n', function() vim.diagnostic.goto_next{popup_opts = {show_header = false}} end)
  vim.keymap.set('n', '<leader>N', function() vim.diagnostic.goto_prev{popup_opts = {show_header = false}} end)

  -- <leader>K will show all diagnostics for the current line in a popup window
  vim.keymap.set('n', '<leader>K', function() vim.lsp.diagnostic.show_line_diagnostics{show_header = false} end)
end

local lsps = { 'sumneko_lua', 'texlab', 'hls' }

require('nvim-lsp-installer').setup{
    ensure_installed = lsps
}

local lspconfig = require('lspconfig')

--- for _, lsp in pairs(lsps) do
---     lspconfig[lsp].setup{}
--- end
lspconfig['sumneko_lua'].setup{

    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
lspconfig['texlab'].setup{}
lspconfig['hls'].setup{}

-- lspconfig.lua.setup{
-- }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Enable lean.nvim, and enable abbreviations and mappings
require('lean').setup{
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    lsp3 = { on_attach = on_attach },
    ft = { default = 'lean3' },
    mappings = true,
}

-- Update error messages even while you're typing in insert mode
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = { spacing = 4 },
    update_in_insert = true,
}
)
