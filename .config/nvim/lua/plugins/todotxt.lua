return {
	{
		--- "phrmendes/todotxt.nvim",
		"konosky/todotxt.nvim",
		branch = "bugfix/cant-open-file",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("todotxt").setup({
				todotxt = vim.fn.expand("~/Documents/todo.txt"),
				donetxt = vim.fn.expand("~/Documents/done.txt"),
			})

			local opts = { noremap = true }

			opts.desc = "todo.txt: toggle task state"
			vim.keymap.set("n", "<c-c><c-x>", require("todotxt").toggle_todo_state, opts)

			opts.desc = "todo.txt: cycle priority"
			vim.keymap.set("n", "<c-c><c-p>", require("todotxt").cycle_priority, opts)

			opts.desc = "Open"
			vim.keymap.set("n", "<leader>.t", require("todotxt").open_todo_file, opts)

			opts.desc = "Sort"
			vim.keymap.set("n", "<leader>.s", require("todotxt").sort_tasks, opts)

			opts.desc = "Sort by (priority)"
			vim.keymap.set("n", "<leader>.P", require("todotxt").sort_tasks_by_priority, opts)

			opts.desc = "Sort by @context"
			vim.keymap.set("n", "<leader>.c", require("todotxt").sort_tasks_by_context, opts)

			opts.desc = "Sort by +project"
			vim.keymap.set("n", "<leader>.p", require("todotxt").sort_tasks_by_project, opts)

			opts.desc = "Sort by due:date"
			vim.keymap.set("n", "<leader>.D", require("todotxt").sort_tasks_by_due_date, opts)

			opts.desc = "Move to done.txt"
			vim.keymap.set("n", "<leader>.d", require("todotxt").move_done_tasks, opts)

			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("todotxt_config", { clear = true }),
				pattern = { "todo.txt", "done.txt" },
				callback = function()
					vim.bo.filetype = "todotxt"
				end,
			})
		end,
	},
}
