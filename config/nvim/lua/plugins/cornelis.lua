return {
  -- https://www.reddit.com/r/agda/comments/15h2pwu/isovectorcornelis_agdamode_for_neovim/
  "isovector/cornelis",
  ft = { "agda" },
  enabled = false,
  build = "stack build",
  dependencies = {
    "kana/vim-textobj-user",
    "neovimhaskell/nvim-hs.vim",
    -- "folke/which-key.nvim",
  },

  init = function()
    local leader = ' c'
    local agda_filetype = function()
      local mappings = {
        { leader .. 'xr', ':CornelisRestart<CR>' },
        { leader .. 'l',  ':CornelisLoad<CR>:CornelisQuestionToMeta<CR>' },
        { leader .. 'r',  ':CornelisRefine<CR>' },
        { leader .. 'c',  ':CornelisMakeCase<CR>' },
        { leader .. ',',  ':CornelisTypeContext<CR>' },
        { leader .. 'd',  ':CornelisTypeInfer<CR>' },
        { leader .. '.',  ':CornelisTypeContextInfer<CR>' },
        { leader .. 's',  ':CornelisSolve<CR>' },
        { leader .. 'a',  ':CornelisAuto<CR>' },
        { leader .. 'b',  ':CornelisPrevGoal<CR>' },
        { leader .. 'f',  ':CornelisNextGoal<CR>' },
        { 'gd',           ':CornelisGoToDefinition<CR>' },
      }
      for _, mapping in ipairs(mappings) do
        local lhs, rhs = unpack(mapping)
        vim.keymap.set('n', lhs, rhs, { buffer = true })
        -- TODO map in insert mode?
      end
    end

    local group = vim.api.nvim_create_augroup('AgdaMapping', {})
    local pattern = { '*.agda', '*.agda.md', '*.lagda.md' }
    local opts = {
      group = group,
      pattern = pattern,
      callback = agda_filetype
    }
    vim.api.nvim_create_autocmd('BufRead', opts)
    vim.api.nvim_create_autocmd('BufNewFile', opts)
    -- au BufRead,BufNewFile *.agda,*agda.md call AgdaFiletype()
    -- " au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>"

    -- local wk = require('which-key')
    -- wk.add { { leader, group = 'Cornelis' } }
    vim.g.cornelis_split_location = 'bottom'
    -- vim.g.cornelis_max_size = 40
  end,
}
