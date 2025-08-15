-- Helper ---------------------------------------

local function keymap(mode, keys, fun, desc, noremap)
  local opt = { silent = true }
  if desc ~= nil then
    opt.desc = desc
  end
  if noremap ~= nil then
    opt.noremap = noremap
  end

  vim.keymap.set(mode, keys, fun, opt)
end

local wk = require("which-key")

-- Supermaven ------------------------------------
keymap("n", "<leader>st", "<cmd>SupermavenToggle<CR>", "[S]upermaven [T]oggle")

-- LSP -------------------------------------------
keymap("n", "<C-Space>", "<cmd>Lspsaga hover_doc<CR>", "Display hover doc")
keymap("n", "<leader>lsr", "<cmd>Lspsaga rename ++project<CR>", "Rename symbol")
keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", "[L]SP [r]estart")
keymap("n", "<leader>lf", function() vim.lsp.buf.code_action() end, "Fix issue")
keymap("n", "<leader>ld", function() vim.lsp.buf.definition() end, "Go to definition")
keymap("n", "gd", function() vim.lsp.buf.definition() end, "Go to definition")

-- General ---------------------------------------

keymap("n", "<Esc>", "<cmd>nohlsearch<Cr>")
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")
keymap("n", "<leader>a", "<cmd>:Alpha<CR>", "Open startup screen");

-- DAP -------------------------------------------

local dap = require("dap")
local dapui = require("dapui")

wk.add({
  { "<leader>D",  group = "DAP" },
  { "<leader>Du",  group = "Debug UI" },
  { "<C-F2>",     "<cmd>DapTerminate<CR>",                                                   desc = "Terminate" },
  { "<C-b>",      "<cmd>DapToggleBreakpoint<CR>",                                            desc = "Toggle Breakpoint" },
  { "<C-S-b>",    function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Set conditional breakpoint" },
  { "<F7>",       "<cmd>DapStepInto<CR>",                                                    desc = "Step Into" },
  { "<F8>",       "<cmd>DapStepOver<CR>",                                                    desc = "Step Over" },
  { "<F9>",       "<cmd>DapContinue<CR>",                                                    desc = "Continue" },
  { "<S-F8>",     "<cmd>DapStepOut<CR>",                                                     desc = "Step out" },
  { "<leader>Dn", "<cmd>DapNew<CR>",                                                         desc = "Enable Debugger" },
  { "<leader>Dc", "<cmd>DapClearBreakpoints<CR>",                                            desc = "Clear Breakpoints" },
  { "<leader>Dd", "<cmd>DapDisconnect<CR>",                                                  desc = "Disconnect" },
  { "<leader>De", "<cmd>DapEval<CR>",                                                        desc = "Eval" },
  { "<leader>Dp", "<cmd>DapPause<CR>",                                                       desc = "Pause" },
  { "<leader>Dut", function() dapui.toggle() end,                                             desc = "Toggle UI" },
  { "<leader>Du1", function() dapui.toggle(1) end,                                             desc = "Toggle UI sidebar" },
  { "<leader>Du2", function() dapui.toggle(2) end,                                             desc = "Toggle UI tray" }
})


-- Buffers ---------------------------------------

keymap("n", "<leader>1", "<cmd>BufferGoto 1<CR>", "Opens buffer #1")
keymap("n", "<leader>2", "<cmd>BufferGoto 2<CR>", "Opens buffer #2")
keymap("n", "<leader>3", "<cmd>BufferGoto 3<CR>", "Opens buffer #3")
keymap("n", "<leader>4", "<cmd>BufferGoto 4<CR>", "Opens buffer #4")
keymap("n", "<leader>5", "<cmd>BufferGoto 5<CR>", "Opens buffer #5")
keymap("n", "<leader>6", "<cmd>BufferGoto 6<CR>", "Opens buffer #6")
keymap("n", "<leader>7", "<cmd>BufferGoto 7<CR>", "Opens buffer #7")
keymap("n", "<leader>8", "<cmd>BufferGoto 8<CR>", "Opens buffer #8")
keymap("n", "<leader>9", "<cmd>BufferGoto 9<CR>", "Opens buffer #9")
keymap("n", "<leader>0", "<cmd>BufferLast<CR>", "Opens the last buffer")
keymap({ "n", "i" }, "<C-F4>", "<cmd>bd!<CR>")

-- Refactoring ----------------------------------

keymap("x", "<leader>re", "<cmd>Refactor extract", "[R]efactor [E]xtract")
keymap("x", "<leader>rf", "<cmd>Refactor extract_to_file <CR>", "[R]efactor extract to [F]ile")
keymap("x", "<leader>rv", "<cmd>Refactor extract_var <CR>", "[R]efactor extract [V]ar")
keymap({ "n", "x" }, "<leader>ri", "<cmd>Refactor inline_var<CR>", "[R]efactor [I]nline var")
keymap("n", "<leader>rif", "<cmd>Refactor inline_func<CR>", "[R]efactor [I]nline [F]unc")
keymap("n", "<leader>rb", "<cmd>Refactor extract_block<CR>", "[R]efactor extract [B]lock")
keymap("n", "<leader>rbf", "<cmd>Refactor extract_block_to_file<CR>", "[R]efactor extract [B]lock to [F]ile")

-- Trouble --------------------------------------

keymap("n", "<leader>td", "<cmd>Trouble diagnostics<CR>", "[T]rouble [D]iagnostics")
keymap("n", "<leader>tx", "<cmd>Trouble close<CR>", "[T]rouble Close [X]")
keymap("n", "<leader>tt", "<cmd>Trouble toggle<CR>", "[T]rouble [T]oggle")

-- Conform --------------------------------------

keymap("", "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, "[F]ormat buffer")

-- Zenmode --------------------------------------

keymap("n", "<leader>z", function()
  require("zen-mode").setup({
    window = {
      width = 90,
      options = {},
    },
  })

  require("zen-mode").toggle()
end, "[Z]en mode")

-- WhichKey -------------------------------------

keymap("n", "<leader>?", "<cmd>WhichKey<CR>", "[?]?? Keymap cheatsheet")

-- Tabs -----------------------------------------

keymap("n", "<S-Tab>", "<<", nil, true)
keymap("v", "<Tab>", ">gv", nil, true)
keymap("v", "<S-Tab>", "<gv", nil, true)

-- Scissors Snippets ----------------------------

keymap({ "n", "v" }, "<leader>sa", "<Cmd>ScissorsAddNewSnippet<CR>", "[S]nippets [A]dd")
keymap({ "n", "v" }, "<leader>se", "<Cmd>ScissorsEditSnippet<CR>", "[S]nippets [E]dit")

-- Neogen ---------------------------------------

keymap({ "n", "v" }, "<leader>ga", "<cmd>Neogen<CR>", "[G]enerate [A]nnotations")

-- Undotree -------------------------------------

keymap("n", "<leader>u", function()
  vim.cmd("UndotreeToggle")
  vim.cmd("wincmd w")
end)

-- NVIM-Tree ------------------------------------

keymap("n", "<C-o>", ":lua vim.g.toggle_tree(false)<CR>", "Open file tree", true)
keymap("n", "<leader>o", ":lua vim.g.toggle_tree(true)<CR>", "Open file tree", true)

-- Telescope ------------------------------------

local tsb = require("telescope.builtin")

keymap("n", "<leader><leader>", "<Cmd>Telescope<CR>", "Opens Telescope")

--keymap("n", "<leader>ts", "<cmd>Telescope symbols<CR>")

keymap("n", "<leader>sk", tsb.keymaps, "[S]earch [K]eymaps")
keymap("n", "<leader>sf", tsb.find_files, "[S]earch [F]iles")
keymap("n", "<leader>sg", tsb.live_grep, "[S]earch by [G]rep")
keymap("n", "<leader>sd", tsb.diagnostics, "[S]earch [D]iagnostics")
keymap("n", "<leader>sr", tsb.resume, "[S]earch [R]esume")
keymap("n", "<leader>s.", tsb.oldfiles, '[S]earch Recent Files ("." for repeat)')
keymap("n", "<leader>/", function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  tsb.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, "[/] Fuzzily search in current buffer")

keymap("n", "<leader>s/", function()
  tsb.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, "[S]earch [/] in Open Files")

-- Shortcut for searching your Neovim configuration files
keymap("n", "<leader>sn", function()
  tsb.find_files({ cwd = vim.fn.stdpath("config") })
end, "[S]earch [N]eovim files")

-- vim: ts=2 sts=2 sw=2 et
