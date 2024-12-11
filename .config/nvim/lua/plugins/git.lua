return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		keys = {
			{ "<Leader>g", "<Cmd>LazyGit<CR>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
}
