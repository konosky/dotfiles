return {
	{
		"phrmendes/todotxt.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("todotxt").setup({
				todotxt = "~/Documents/todo.txt",
				donetxt = "~/Documents/done.txt",
			})
		end,
	},
}
