return {
	"Exafunction/codeium.vim",
	config = function()
		vim.g.codeium_enabled = false

--	require("codeium").setup({
--			enable_cmp_source = false,
--			virtual_text = {
--				enabled = true,
--				manual = false,
--				idle_delay = 75,
--			},
--		})

--		require("codeium.virtual_text").set_statusbar_refresh(function()
--			require("lualine").refresh()
--		end)
	end,
}
