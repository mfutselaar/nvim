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

-- General ---------------------------------------

keymap("n", "<Esc>", "<cmd>nohlsearch<Cr>")
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

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
keymap({ "n", "i" }, "<C-w>", "<cmd>bd!<CR>")

-- Trouble --------------------------------------

keymap("n", "<leader>tt", function()
	require("trouble").toggle()
end, "[T]oggle [T]rouble")

--keymap("n", "[t", function()
--	require("trouble").next({ skip_groups = true, jump = true })
--end)

--keymap("n", "]t", function()
--	require("trouble").previous({ skip_groups = true, jump = true })
--end)

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

-- Codeium --------------------------------------

keymap({ "n", "v" }, "<leader>ce", "<cmd>Codeium Enable<CR>", "Codeium Enable")
keymap({ "n", "v" }, "<leader>cd", "<cmd>Codeium Disable<cr>", "Codeium Disable")

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
