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
    gopls = {},
    bashls = {},
    html = {},
    -- pylsp = {},
}

local function get_table_keys(tab)
    local keyset = {}
    for k, _ in pairs(tab) do
        keyset[#keyset + 1] = k
    end
    return keyset
end

-- require('mason').setup{}
require('nvim-lsp-installer').setup {
    ensure_installed = get_table_keys(lsps),
    automatic_installation = true,
}
-- require('lsp_signature').setup{}

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local wk = require('which-key')
    wk.register({
        ['gd']         = { vim.lsp.buf.definition, 'lsp::definition' },
        ['gD']         = { vim.lsp.buf.declaration, 'lsp::declaration' },
        ['K']          = { vim.lsp.buf.hover, 'lsp::hover' },
        ['gi']         = { vim.lsp.buf.implementation, 'lsp::implementation' },
        ['<leader>D']  = { vim.lsp.buf.type_definition, 'lsp::type_definition' },
        ['<leader>rn'] = { vim.lsp.buf.rename, 'lsp::rename_variable' },
        ['<leader>fm'] = { vim.lsp.buf.formatting, 'lsp::code_formatting' },
        ['<leader>n']  = { vim.diagnostic.goto_next, 'lsp::next_diagnostic' },
        ['<leader>N']  = { vim.diagnostic.goto_prev, 'lsp::prev_diagnostic' },
        ['<leader>ca'] = { vim.lsp.buf.code_action, 'lsp::code_action' },
        ['gR']         = { vim.lsp.buf.references, 'lsp::references' },
        ['<C-k>']      = { vim.lsp.buf.signature_help, 'lsp::signature_help' },
        ['<leader>K']  = { vim.diagnostic.open_float, 'lsp::line_diagnostic' },
    }, { buffer = bufnr })

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
    ---- vim.keymap.set('n', '<leader>wl', function()
    ----     print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
    ---- end, bufopts)
end

local border = 'single'

local capabilities = require('cmp_nvim_lsp')
    .update_capabilities(vim.lsp.protocol.make_client_capabilities())

local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

vim.diagnostic.config {
    severity_sort = true,
    float = {
        border = border,
        header = false
    },
}

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
require('lean').setup {
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
