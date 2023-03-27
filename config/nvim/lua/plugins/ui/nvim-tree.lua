return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        require('nvim-tree').setup {
            respect_buf_cwd = true
        }
        vim.cmd [[
        function s:opendir()
            if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
                execute 'cd ' .. argv()[0]
                NvimTreeOpen
                endif
                endfunction
                augroup nvimtreeOpenDirectory
                autocmd StdinReadPre * let s:std_in=1
                autocmd VimEnter * call <SID>opendir()
                augroup END
        ]]
    end
}

