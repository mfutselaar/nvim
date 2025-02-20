-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

vim.keymap.set('n', '<leader>1', '<cmd>BufferGoto 1<CR>', { silent = true })
vim.keymap.set('n', '<leader>2', '<cmd>BufferGoto 2<CR>', { silent = true })
vim.keymap.set('n', '<leader>3', '<cmd>BufferGoto 3<CR>', { silent = true })
vim.keymap.set('n', '<leader>4', '<cmd>BufferGoto 4<CR>', { silent = true })
vim.keymap.set('n', '<leader>5', '<cmd>BufferGoto 5<CR>', { silent = true })
vim.keymap.set('n', '<leader>6', '<cmd>BufferGoto 6<CR>', { silent = true })
vim.keymap.set('n', '<leader>7', '<cmd>BufferGoto 7<CR>', { silent = true })
vim.keymap.set('n', '<leader>8', '<cmd>BufferGoto 8<CR>', { silent = true })
vim.keymap.set('n', '<leader>9', '<cmd>BufferGoto 9<CR>', { silent = true })
vim.keymap.set('n', '<leader>0', '<cmd>BufferLast<CR>', { silent = true })
vim.keymap.set('n', '<leader>tp', '<cmd>Telescope projects<CR>', { silent = true })
vim.keymap.set('n', '<leader>ts', '<cmd>Telescope symbols<CR>', { silent = true })
vim.keymap.set('n', '<leader>tk', '<cmd>Telescope keymaps<CR>', { silent = true })
vim.keymap.set('n', '<leader>td', '<Cmd>Telescope diagnostic<CR>', { silent = true })
vim.keymap.set('n', '<leader>t', '<Cmd>Telescope<CR>', { silent = true })
vim.keymap.set('n', '<leader>?', '<cmd>WhichKey<CR>', { silent = true })
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sc', '<Cmd>ScissorsAddNewSnippet<CR>', { silent = true })
vim.keymap.set('n', '<leader>se', '<Cmd>ScissorsEditSnippet<CR>', { silent = true })
