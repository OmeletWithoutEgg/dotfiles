local border = 'single'

local function config()
  -- vim.opt.completeopt = {
  --   'menu', 'menuone',
  --   -- 'noselect',
  --   'preview',
  -- }

  -- vim.opt.pumheight = 5

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup.filetype('tex', {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          -- cmp.select_next_item()
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
    window = {
      -- completion = {
      --   border = border,
      --   winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
      -- },
      documentation = {
        border = border,
        winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
      },
    },

    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        -- TODO
        -- vim_item.kind = string.format('%s %s', icons.kind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          nvim_lsp = '[lsp]',
          luasnip = '[snip]',
          buffer = '[buf]',
          path = '[path]',
          nvim_lua = '[nvim_api]',
        })[entry.source.name]
        return vim_item
      end,
    },
  })
end

local luasnip = {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- build = 'make install_jsregexp',
  config = function()
    local ls = require('luasnip')
    ls.config.set_config {
      history = true,
      -- Update more often, :h events for more info.
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
    }

    -- extend html snippets to react files
    ls.filetype_extend('javascriptreact', { 'html' })
    ls.filetype_extend('typescriptreact', { 'html' })

    -- load snippets (friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()
    -- TODO manage my own snippets
    -- @e -> \epsilon
    -- enumerate, itemize, aligned, math zone
    -- btw remember to use tsf
  end,
  event = 'VeryLazy',
}

return {
  'hrsh7th/nvim-cmp',
  config = config,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-nvim-lua',
    -- 'hrsh7th/cmp-cmdline',
    -- 'hrsh7th/cmp-path',
    luasnip,
  },
  event = 'VeryLazy',
}
