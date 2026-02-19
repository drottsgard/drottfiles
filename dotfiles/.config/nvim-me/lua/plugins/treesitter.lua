return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- Install parsers
    require('nvim-treesitter').install {
      'lua',
      'javascript',
      'typescript',
      'tsx',
      'html',
      'css',
      'json',
      'yaml',
      'bash',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
    }

    -- Enable treesitter highlighting and folding for all filetypes with a parser
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldlevel = 99
        end
      end,
    })
  end,
}
