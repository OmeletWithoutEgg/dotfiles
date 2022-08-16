local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

vim.cmd [[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]
local cmp = require('cmp')
cmp.setup {
    completion = { autocomplete = false },
    snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
    mapping = {
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            -- elseif vim.fn['vsnip#available'](1) == 1 then
            --     feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            -- elseif vim.fn['vsnip#jumpable'](-1) == 1 then
            --     feedkey('<Plug>(vsnip-jump-prev)', '')
            elseif has_words_before() then
                cmp.complete()
                cmp.select_prev_item()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' },
        { name = 'path' },
        -- { name = 'orgmode' },
        { { name = 'buffer' }, }
    }
}
