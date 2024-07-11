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
          globals = {
            'vim', -- neovim config
            'window', -- wezterm config
          }
        }
      },
    },
  },
  texlab = {},
  -- hls = {},
  -- gopls = {},
  bashls = {
    -- filetypes = {'bash', 'zsh'},
  },
  html = {},
  clangd = {},
  -- ccls = {},
  tsserver = {},
  pylsp = {},
  -- ~/.local/share/nvim/mason/packages/python-lsp-server/venv/pyvenv.cfg
  -- include-system-site-packages = true

  -- ruby_ls = {},
  -- solargraph = {}, -- ruby
  -- vuels = {},
  volar = {},
  -- marksman = { filetypes = { 'markdown', 'vimwiki' } },
  cssls = {},
  -- typos_lsp = {
  --   -- filetypes = { 'markdown', 'vimwiki' }
  -- },
}

local border = 'single'

local ensure_installed = vim.tbl_keys(lsps)

local function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

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
    ['gr']         = { vim.lsp.buf.references, 'lsp::references' },
    ---
    ['<leader>rn'] = { vim.lsp.buf.rename, 'lsp::rename_variable' },
    ['<leader>fm'] = { vim.lsp.buf.format, 'lsp::code_formatting' },
    ['<leader>ca'] = { vim.lsp.buf.code_action, 'lsp::code_action' },
    [']d']         = { vim.diagnostic.goto_next, 'lsp::next_diagnostic' },
    ['[d']         = { vim.diagnostic.goto_prev, 'lsp::prev_diagnostic' },
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

local handlers = {
  ['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}


local lspconfig_opts = {
  lsps = lsps,
  border = border,
  ensure_installed = ensure_installed,
  on_attach = on_attach,
  handlers = handlers,
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
    },
    'williamboman/mason-lspconfig.nvim',
    -- 'hrsh7th/cmp-nvim-lsp',
  },
  event = { 'BufReadPre', 'VeryLazy' },
  opts = lspconfig_opts,
  config = function()
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('mason').setup {
      ui = { border = border },
    }
    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
    }

    require('lspconfig.ui.windows').default_options = { border = border }

    vim.diagnostic.config {
      severity_sort = true,
      float = {
        border = border,
        header = false
      },
    }

    local default_lsp_opts = {
      on_attach = on_attach,
      -- capabilities = capabilities,
      handlers = handlers,
    }

    local lspconfig = require('lspconfig')
    for lsp, opts in pairs(lsps) do
      lspconfig[lsp].setup(vim.tbl_extend('force', default_lsp_opts, opts))
    end
  end,
}
