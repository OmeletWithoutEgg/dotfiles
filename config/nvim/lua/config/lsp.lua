local lsps = {
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'packer_plugins' }
                }
            }
        }
    },
    texlab = {},
    hls = {},
}

-- require('mason').setup{}
require('nvim-lsp-installer').setup({
    ensure_installed = lsps,
    automatic_installation = true,
})
-- require('lsp_signature').setup{}

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
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

    vim.keymap.set('n', '<leader>n', function() vim.diagnostic.goto_next{popup_opts = {show_header = false}} end)
    vim.keymap.set('n', '<leader>N', function() vim.diagnostic.goto_prev{popup_opts = {show_header = false}} end)

    -- <leader>K will show all diagnostics for the current line in a popup window
    vim.keymap.set('n', '<leader>K', function() vim.diagnostic.show_line_diagnostics{show_header = false} end)
end

local capabilities = require('cmp_nvim_lsp')
    .update_capabilities(vim.lsp.protocol.make_client_capabilities())

local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

vim.diagnostic.config{ float = { border = 'rounded' } }

local lspconfig = require('lspconfig')

local lsp_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
}

for lsp, opts in pairs(lsps) do
    lspconfig[lsp].setup(vim.tbl_extend('force', lsp_opts, opts))
end

-- Enable lean.nvim, and enable abbreviations and mappings
require('lean').setup{
    abbreviations = { builtin = true },
    lsp = lsp_opts,
    lsp3 = lsp_opts,
    ft = { default = 'lean3' },
    mappings = true,
}

-- Update error messages even while you're typing in insert mode
--- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--- vim.lsp.diagnostic.on_publish_diagnostics, {
---     underline = false,
---     virtual_text = { spacing = 4 },
---     update_in_insert = true,
--- }
--- )

--- local lint = require('lint')
--- 
--- lint.linters.mathlib = {
---   cmd = 'scripts/lint-style.py',
---   stdin = true,
---   args = {'/dev/stdin'},
---   stream = 'stdout',
---   ignore_exitcode = true,
---   parser = require('lint.parser').from_errorformat('::%trror file=%f\\,line=%l\\,code=ERR_%[A-Z]%\\+::ERR_%[A-Z]\\*:%m'),
--- }
--- 
--- lint.linters_by_ft = {
---   lean3 = { 'mathlib' };
---   python = { 'flake8' };
--- }
