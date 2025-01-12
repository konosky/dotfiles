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
			{
				"<Leader>G",
				'<Cmd>lua require("FTerm"):new({ cmd = "git add -A && env OCO_GITPUSH=false oco --yes; echo exit && read -s -n 1" }):open()<CR>',
				desc = "OpenCommit",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
}
