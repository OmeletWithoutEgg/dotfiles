local language_servers = {
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
            'vim',    -- neovim config
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
  ts_ls = {},
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

  config = function()
    local border = 'single'
    require('mason').setup {
      ui = { border = border },
    }
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(language_servers)
    }

    vim.diagnostic.config {
      severity_sort = true,
      float = {
        border = border,
        header = false
      },
    }
    require('lspconfig.ui.windows').default_options = { border = border }

    local lspconfig = require('lspconfig')
    local default_opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local function map(lhs, rhs)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr })
        end

        map('gd', vim.lsp.buf.definition)
        map('gD', vim.lsp.buf.declaration)

        map('gi', vim.lsp.buf.implementation)
        map('gs', vim.lsp.buf.type_definition)
        map('gr', vim.lsp.buf.references)

        map('<leader>rn', vim.lsp.buf.rename)
        map('<leader>fm', vim.lsp.buf.format)
        map('<leader>ca', vim.lsp.buf.code_action)
        map('<C-k>', vim.lsp.buf.signature_help)
        -- 'K', '[d', ']d', '<C-W>d' are all mapped by default
      end,

      handlers = {
        ["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }
    }

    for server_name, opts in pairs(language_servers) do
      lspconfig[server_name].setup(vim.tbl_extend('force', default_opts, opts))
    end
  end
}
