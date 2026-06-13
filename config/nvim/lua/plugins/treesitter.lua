return {
  'romus204/tree-sitter-manager.nvim',
  opts = {
    assume_installed = {
      'c', 'lua', 'markdown', 'markdown_inline', 'vim', 'vimdoc',
    },
    ensure_installed = {
      'dockerfile', 'make',
      'cpp', 'rust', 'javascript',
      'python', 'ruby', 'bash',
      'latex', 'haskell',
      'toml', 'yaml', 'html', 'css', 'rasi', 'scss',
    }
  },
}
