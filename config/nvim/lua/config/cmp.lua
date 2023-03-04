vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'preview' }

vim.cmd [[
    imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
]]

local cmp = require('cmp')
cmp.setup {
    -- completion = { autocomplete = false },
    preselect = cmp.PreselectMode.Item,
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
    mapping = cmp.mapping.preset.insert({
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),

    -- formatting = {
    --     fields = { 'kind', 'abbr', 'menu' },
    -- },

    sources = {
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
        -- { name = 'vsnip',    keyword_length = 3 },
        -- { name = 'buffer',   keyword_length = 3 },
        -- { name = 'orgmode' },
    },
}

-- `/` cmdline setup.
-- cmp.setup.cmdline('/', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer', keyword_length = 3 }
--     },
-- })

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline', keyword_length = 3 }
    }),
})
