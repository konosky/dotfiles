return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dark_variant = "moon",
				styles = {
					transparency = true,
				},
			})

			vim.o.background = "dark"
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
