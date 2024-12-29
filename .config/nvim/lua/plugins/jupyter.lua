return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
		end,
	},
	{
		"goerz/jupytext.nvim",
		version = "0.2.0",
		opts = {},
	},
	{
		-- "GCBallesteros/NotebookNavigator.nvim",
		"konosuke-sakai/NotebookNavigator.nvim",
		branch = "bugfix/remove-trailing-marker",
		keys = {
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
			},
			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
			},
			{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
			{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		},
		dependencies = {
			"echasnovski/mini.comment",
			"hkupty/iron.nvim",
			"anuvyklack/hydra.nvim",
		},
		event = "VeryLazy",
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({
				cell_markers = {
					markdown = "```",
				},
				activate_hydra_keys = "<leader>h",
				repl_provider = "molten",
			})
		end,
	},
}
