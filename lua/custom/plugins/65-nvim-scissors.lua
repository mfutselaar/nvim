return {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim',
  config = function()
    require('scissors').setup {
      snippetDir = '~/.config/nvim/snippets/',
      jsonFormatter = 'jq',
    }

    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { '~/.config/nvim/snippets/' },
    }
  end,
}
