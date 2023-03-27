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
          globals = { 'vim' }
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
  vuels = {},
  -- volar = {},
  marksman = {},
  cssls = {},
}

local border = 'single'

local function get_table_keys(tab)
  local keyset = {}
  for k, _ in pairs(tab) do
    keyset[#keyset + 1] = k
  end
  return keyset
end

local ensure_installed = get_table_keys(lsps)

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = border,
    header = false
  },
}

local function on_attach(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  local wk = require('which-key')
  wk.register({
    name           = 'lsp',
    ['gd']         = { vim.lsp.buf.definition, 'lsp::definition' },
    ['gD']         = { vim.lsp.buf.declaration, 'lsp::declaration' },
    ['gi']         = { vim.lsp.buf.implementation, 'lsp::implementation' },
    ['gs']         = { vim.lsp.buf.type_definition, 'lsp::type_definition' },
    ['K']          = { vim.lsp.buf.hover, 'lsp::hover' },
    ['gR']         = { vim.lsp.buf.references, 'lsp::references' },
    ---
    ['<leader>rn'] = { vim.lsp.buf.rename, 'lsp::rename_variable' },
    ['<leader>fm'] = { vim.lsp.buf.format, 'lsp::code_formatting' },
    ['<leader>ca'] = { vim.lsp.buf.code_action, 'lsp::code_action' },
    ['[d']         = { vim.diagnostic.goto_next, 'lsp::next_diagnostic' },
    [']d']         = { vim.diagnostic.goto_prev, 'lsp::prev_diagnostic' },
    ['<C-k>']      = { vim.lsp.buf.signature_help, 'lsp::signature_help' },
    -- ['<leader>K']  = { vim.diagnostic.open_float, 'lsp::line_diagnostic' },
  }, { buffer = bufnr })

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
  ---- vim.keymap.set('n', '<leader>wl', function()
  ----     print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  ---- end, bufopts)
end

return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason').setup {
        ui = { border = border },
      }
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
      }

      local lspconfig = require('lspconfig')
      require('lspconfig.ui.windows').default_options = { border = border }
      -- require('lspconfig.ui.windows').default_options = { border = border }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local handlers = {
        ['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }

      local lsp_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
      }

      for lsp, opts in pairs(lsps) do
        lspconfig[lsp].setup(vim.tbl_extend('force', lsp_opts, opts))
      end
    end
  },
  -- 'ray-x/lsp_signature.nvim',
}
