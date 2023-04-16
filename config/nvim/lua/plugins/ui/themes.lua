local function VeryLazy(plugins)
  for key, plugin in pairs(plugins) do
    if type(plugin) == 'string' then
      plugins[key] = { plugin, event = 'VeryLazy' }
    else
      plugins[key].event = 'VeryLazy'
    end
  end
  return plugins
end

return {
  'hzchirs/vim-material',
  VeryLazy {
    'kaicataldo/material.vim',
    'lifepillar/vim-solarized8',
    'cpea2506/one_monokai.nvim',
    'shaunsingh/nord.nvim',
    'navarasu/onedark.nvim',
    'Mofiqul/vscode.nvim',
    'folke/tokyonight.nvim',
  },
}
