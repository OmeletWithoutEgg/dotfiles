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
            -- https://www.reddit.com/r/wezterm/comments/16wuyhh/lua_autocomplete_in_neovim/
            -- https://github.com/wezterm/wezterm/issues/3132
            'window', -- wezterm config
          }
        },
        workspace = {
          -- https://github.com/neovim/neovim/discussions/24119
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          },
        },
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
  vue_ls = {},
  -- marksman = { filetypes = { 'markdown', 'vimwiki' } },
  cssls = {},
  -- typos_lsp = {
  --   -- filetypes = { 'markdown', 'vimwiki' }
  -- },
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
    },
  },
  event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },

  config = function()
    local border = 'single'
    require('mason').setup {
      ui = { border = border },
    }
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(language_servers)
    }

    vim.diagnostic.config {
      virtual_text = true,
      signs = false,
      float = { border = border },
    }

    -- local lspconfig = require('lspconfig')
    local default_opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

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
        map('K', function()
          vim.lsp.buf.hover { border = border }
        end)
        map('[d', function()
          vim.diagnostic.jump { count = -1, float = true }
        end)
        map(']d', function()
          vim.diagnostic.jump { count = 1, float = true }
        end)
      end,
    }

    -- for server_name, opts in pairs(language_servers) do
    --   vim.lsp.config(server_name, vim.tbl_extend('force', default_opts, opts))
    --   vim.lsp.enable(server_name)
    -- end

    vim.lsp.config('*', default_opts)
    vim.lsp.config('lua_ls',
      vim.tbl_extend('force', default_opts, language_servers.lua_ls)
    )
  end
}
