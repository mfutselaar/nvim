-- Helper ---------------------------------------

local function keymap(views, keys, fun, desc, noremap)
  local opt = { silent = true }
  if (desc == nil) then
    opt.desc = desc
  end
  if (noremap ~= nil) then
    opt.noremap = noremap
  end

  vim.keymap.set(views, keys, fun, opt)
end


-- General ---------------------------------------

keymap('n', '<Esc>', '<cmd>nohlsearch<CE>')
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', "Exit terminal mode")

-- Buffers ---------------------------------------

keymap('n', '<leader>1', '<cmd>BufferGoto 1<CR>')
keymap('n', '<leader>2', '<cmd>BufferGoto 2<CR>')
keymap('n', '<leader>3', '<cmd>BufferGoto 3<CR>')
keymap('n', '<leader>4', '<cmd>BufferGoto 4<CR>')
keymap('n', '<leader>5', '<cmd>BufferGoto 5<CR>')
keymap('n', '<leader>6', '<cmd>BufferGoto 6<CR>')
keymap('n', '<leader>7', '<cmd>BufferGoto 7<CR>')
keymap('n', '<leader>8', '<cmd>BufferGoto 8<CR>')
keymap('n', '<leader>9', '<cmd>BufferGoto 9<CR>')
keymap('n', '<leader>0', '<cmd>BufferLast<CR>')
keymap({ 'n', 'i' }, '<C-w>', '<cmd>bd!<CR>')
-- WhichKey -------------------------------------

keymap('n', '<leader>?', '<cmd>WhichKey<CR>')

-- Tabs -----------------------------------------

keymap('n', '<Tab>', '>>', nil, true)
keymap('n', '<S-Tab>', '<<', nil, true)
keymap('v', '<Tab>', '>gv', nil, true)
keymap('v', '<S-Tab>', '<gv', nil, true)

-- Scissors Snippets

keymap('n', '<leader>sc', '<Cmd>ScissorsAddNewSnippet<CR>')
keymap('n', '<leader>se', '<Cmd>ScissorsEditSnippet<CR>')

-- Telescope -------------------------------------

local tsb = require 'telescope.builtin'

keymap('n', '<leader><leader>', '<Cmd>Telescope<CR>')

keymap('n', '<leader>tp', '<cmd>Telescope projects<CR>')
keymap('n', '<leader>ts', '<cmd>Telescope symbols<CR>')
keymap('n', '<leader>tk', '<cmd>Telescope keymaps<CR>')
keymap('n', '<leader>td', '<Cmd>Telescope diagnostic<CR>')

keymap('n', '<leader>sh', tsb.help_tags, "[S]earch [H]elp")
keymap('n', '<leader>sk', tsb.keymaps, "[S]earch [K]eymaps")
keymap('n', '<leader>sf', tsb.find_files, "[S]earch [F]iles")
keymap('n', '<Alt>ss', tsb.builtin, "[S]earch [S]elect Telescope")
keymap('n', '<leader>sw', tsb.grep_string, "[S]earch current [W]ord")
keymap('n', '<leader>sg', tsb.live_grep, "[S]earch by [G]rep")
keymap('n', '<leader>sd', tsb.diagnostics, "[S]earch [D]iagnostics")
keymap('n', '<leader>sr', tsb.resume, "[S]earch [R]esume")
keymap('n', '<leader>s.', tsb.oldfiles, "[S]earch Recent Files (\".\" for repeat)")
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  tsb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, "[/] Fuzzily search in current buffer")

keymap('n', '<leader>s/', function()
  tsb.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, "[S]earch [/] in Open Files")

-- Shortcut for searching your Neovim configuration files
keymap('n', '<leader>sn', function()
  tsb.find_files { cwd = vim.fn.stdpath 'config' }
end, "[S]earch [N]eovim files")

-- vim: ts=2 sts=2 sw=2 et
