return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  --  dependencies = {
  --    'nvim-lua/plenary.nvim',
  --    'hrsh7th/nvim-cmp',
  --  },
  config = function()
    vim.g.codeium_enabled = false
  end,
}
