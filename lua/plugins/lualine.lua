return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "palenight",
			},
			sections = {
				lualine_a = {
					"mode",
					'vim.api.nvim_call_function("codeium#GetStatusString", {})',
				},
			},
		})
	end,
}
