local lsps = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim', 'packer_plugins' }
        }
      },
    },
  },
  texlab = {},
  hls = {},
  -- gopls = {},
  bashls = {},
  html = {},
  clangd = {},
  -- ccls = {},
  tsserver = {},
  pylsp = {},
  -- solargraph = {}, -- ruby
  vuels = {
    root_dir = require('lspconfig.util').root_pattern('header.php', 'package.json', 'style.css', 'webpack.config.js')
  },
  -- volar = {},
  marksman = {},
  cssls = {},
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
  ui = {
    -- Whether to automatically check for outdated servers when opening the UI window.
    check_outdated_servers_on_open = true,
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'single',
  },
}
-- require('lsp_signature').setup{}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local wk = require('which-key')
  wk.register({
    name               = 'lsp',
        ['gd']         = { vim.lsp.buf.definition     , 'lsp::definition' }     ,
        ['gD']         = { vim.lsp.buf.declaration    , 'lsp::declaration' }    ,
        ['K']          = { vim.lsp.buf.hover          , 'lsp::hover' }          ,
        ['gi']         = { vim.lsp.buf.implementation , 'lsp::implementation' } ,
        ['<leader>D']  = { vim.lsp.buf.type_definition, 'lsp::type_definition' },
        ['<leader>rn'] = { vim.lsp.buf.rename         , 'lsp::rename_variable' },
        ['<leader>fm'] = { vim.lsp.buf.format         , 'lsp::code_formatting' },
        ['<leader>n']  = { vim.diagnostic.goto_next   , 'lsp::next_diagnostic' },
        ['<leader>N']  = { vim.diagnostic.goto_prev   , 'lsp::prev_diagnostic' },
        ['<leader>ca'] = { vim.lsp.buf.code_action    , 'lsp::code_action' }    ,
        ['gR']         = { vim.lsp.buf.references     , 'lsp::references' }     ,
        ['<C-k>']      = { vim.lsp.buf.signature_help , 'lsp::signature_help' } ,
        ['<leader>K']  = { vim.diagnostic.open_float  , 'lsp::line_diagnostic' },
  }, { buffer          = bufnr })

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
  ---- vim.keymap.set('n', '<leader>wl', function()
  ----     print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  ---- end, bufopts)
end

local border = 'single'

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
require('lspconfig.ui.windows').default_options = { border = border }

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
