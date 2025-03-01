vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("editor_config", { clear = true }),
	callback = function()
		vim.o.tabstop = 2
		vim.o.shiftwidth = 2
		vim.o.expandtab = true

		vim.o.undofile = true

		vim.o.number = true
		vim.o.relativenumber = true

		vim.o.cursorline = true

		vim.o.list = true
		vim.o.listchars = "tab:▎ ,trail:·,nbsp:+,eol:↵,space:·,extends:»,precedes:«"

		vim.o.clipboard = "unnamedplus"

		vim.g.mapleader = " "

		vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

		vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true })
		vim.keymap.set("i", "<C-n>", "<Down>", { noremap = true })
		vim.keymap.set("i", "<C-p>", "<Up>", { noremap = true })
		vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true })

		vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true })
		vim.keymap.set("i", "<C-e>", "<End>", { noremap = true })

		vim.keymap.set("n", "<C-d>", "<Cmd>quit<CR>", { noremap = true })

		vim.keymap.set("v", ">", ">gv", { noremap = true })
		vim.keymap.set("v", "<", "<gv", { noremap = true })
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("lazy_automatic_update", { clear = true }),
	callback = function()
		if require("lazy.status").has_updates then
			require("lazy").update({ show = false })
		end
	end,
})

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"pocco81/auto-save.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowLove",
				"RainbowGold",
				"RainbowRose",
				"RainbowPine",
				"RainbowFoam",
				"RainbowIris",
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				local palette = require("rose-pine.palette")

				vim.api.nvim_set_hl(0, "RainbowLove", { fg = palette.love })
				vim.api.nvim_set_hl(0, "RainbowGold", { fg = palette.gold })
				vim.api.nvim_set_hl(0, "RainbowRose", { fg = palette.rose })
				vim.api.nvim_set_hl(0, "RainbowPine", { fg = palette.pine })
				vim.api.nvim_set_hl(0, "RainbowFoam", { fg = palette.foam })
				vim.api.nvim_set_hl(0, "RainbowIris", { fg = palette.iris })
			end)

			require("ibl").setup({
				indent = { highlight = highlight },
				exclude = {
					filetypes = {
						"dashboard",
					},
				},
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("fzf-lua").setup({})

			vim.keymap.set("n", "<Leader>fb", require("fzf-lua").buffers, { desc = "fzf buffers" })
			vim.keymap.set("n", "<Leader>ff", require("fzf-lua").files, { desc = "fzf files" })
			vim.keymap.set("n", "<Leader>fq", require("fzf-lua").quickfix, { desc = "fzf quickfixes" })
			vim.keymap.set("n", "<Leader>fl", require("fzf-lua").lines, { desc = "fzf lines" })
			vim.keymap.set("n", "<Leader>ft", require("fzf-lua").tabs, { desc = "fzf tabs" })
			vim.keymap.set("n", "<Leader>fp", require("fzf-lua").live_grep, { desc = "fzf patterns" })
			vim.keymap.set("n", "<Leader>fs", require("fzf-lua").lsp_workspace_symbols, { desc = "fzf symbols" })

			vim.keymap.set("n", "<C-p>", function()
				require("fzf-lua").fzf_exec("ghq list --full-path", {
					actions = {
						["default"] = function(selected, opts)
							vim.cmd("cd " .. selected[1])
						end,
					},
					fzf_opts = {
						["--preview"] = "git -C {} graph -n 100 --color always --no-pager",
					},
				})
			end, { desc = "fzf projects" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = require("nvim-treesitter.parsers")

			function _G.treesitter_automatic_parser_setup()
				local lang = parsers.get_buf_lang()
				if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
					vim.schedule_wrap(function()
						vim.cmd("TSInstall " .. lang)
					end)()
				end
			end

			vim.cmd("autocmd FileType * :lua treesitter_automatic_parser_setup()")

			local configs = require("nvim-treesitter.configs")

			configs.setup({
				highlight = {
					enable = true,
				},
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			config = {
				project = {
					action = function()
						vim.cmd("FzfLua files")
					end,
				},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<Leader>q", "<Cmd>q<CR>", desc = "Quit" },
			{ "<Leader>Q", "<Cmd>qall<CR>", desc = "Quit all" },

			{ "<Leader>b", group = "Buffer" },

			{ "<Leader>bp", "<Cmd>bprevious<CR>", desc = "Previous" },
			{ "<Leader>bn", "<Cmd>bnext<CR>", desc = "Next" },

			{ "<Leader>bs", "<Cmd>split<CR>", desc = "Split horizontal" },
			{ "<Leader>bS", "<Cmd>vsplit<CR>", desc = "Split vertical" },

			{ "<Leader>bd", "<Cmd>bdelete<CR>", desc = "Delete" },

			{ "<Leader>bh", "<C-w>h", desc = "Left" },
			{ "<Leader>bj", "<C-w>j", desc = "Down" },
			{ "<Leader>bk", "<C-w>k", desc = "Up" },
			{ "<Leader>bl", "<C-w>l", desc = "Right" },

			{ "<Leader>bb", "<C-w><C-w>", desc = "Cycle" },

			{ "<Leader>T", group = "Tab" },

			{ "<Leader>Te", "<Cmd>tabedit<CR>", desc = "Open" },
			{ "<Leader>Tc", "<Cmd>tabclose<CR>", desc = "Close" },

			{ "<Leader>Tp", "<Cmd>tabprevious<CR>", desc = "Previous" },
			{ "<Leader>Tn", "<Cmd>tabnext<CR>", desc = "Next" },

			{ "<Leader>w", "<Cmd>write<CR>", desc = "Write" },

			{ "<Leader>s", "<Cmd>split<CR>", desc = "Split horizontal" },
			{ "<Leader>S", "<Cmd>vsplit<CR>", desc = "Split vertical" },

			{ "<Leader>d", "<Cmd>bdelete<CR>", desc = "Delete" },

			{ "<Leader>h", "<C-w>h", desc = "Left" },
			{ "<Leader>j", "<C-w>j", desc = "Down" },
			{ "<Leader>k", "<C-w>k", desc = "Up" },
			{ "<Leader>l", "<C-w>l", desc = "Right" },

			{ "<leader>L", "<Cmd>Lazy<CR>", desc = "Lazy" },

			{ "<leader>M", "<Cmd>Mason<CR>", desc = "Mason" },

			{ "<Leader>c", group = "QuickFix" },

			{
				"<Leader>ct",
				function()
					local windows = vim.fn.getwininfo()
					for _, window in pairs(windows) do
						if window.quickfix == 1 then
							vim.cmd("cclose")
							return
						end
					end

					vim.cmd("copen")
				end,
				desc = "Toggle",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
				javascript = { "biome" },
				lua = { "stylua" },
				python = { "black" },
				yaml = { "yamlfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
	{
		"VidocqH/lsp-lens.nvim",
		opts = {},
	},
	{
		"chikko80/error-lens.nvim",
		event = "BufRead",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {},
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			vim.keymap.set("n", "<C-.>", '<Cmd>lua require("FTerm").toggle()<CR>')
			vim.keymap.set("t", "<C-.>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
		end,
	},
	{
		"nvim-focus/focus.nvim",
		version = false,
		config = true,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					stages = "static",
				},
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				width = 0.85,
			},
		},
		keys = {
			{ "<Leader>z", "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
		},
	},
	{
		"Isrothy/neominimap.nvim",
		enabled = true,
		lazy = false,
		keys = {
			-- Global Minimap Controls
			{ "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
			{ "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
			{ "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
			{ "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

			-- Window-Specific Minimap Controls
			{ "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
			{ "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
			{ "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
			{ "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

			-- Tab-Specific Minimap Controls
			{ "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
			{ "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
			{ "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
			{ "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

			-- Buffer-Specific Minimap Controls
			{ "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
			{ "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
			{ "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
			{ "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

			---Focus Controls
			{ "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
			{ "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
			{ "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
		},
		init = function()
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36

			vim.g.neominimap = {
				auto_enable = true,
			}
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.opt.termguicolors = true

			require("nvim-tree").setup()
		end,
		keys = {
			{ "<Leader>tt", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle" },
		},
	},
	{
		"is0n/jaq-nvim",
		opts = {
			cmds = {
				internal = {
					lua = "luafile %",
					vim = "source %",
				},
				external = {
					javascript = "node %",
					python = "python3 %",
					go = "go run %",
				},
			},
			behavior = {
				startinsert = true,
			},
		},
		keys = {
			{ "<Leader>r", "<Cmd>Jaq<CR>", desc = "Run" },
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},
	{
		"3rd/image.nvim",
		opts = {},
	},
	{
		"edluffy/hologram.nvim",
		opts = {
			auto_display = true,
		},
	},
	{
		"3rd/diagram.nvim",
		dependencies = {
			"3rd/image.nvim",
		},
		opts = {},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
	},
	{
		"https://codeberg.org/esensar/nvim-dev-container",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
	{
		"sheerun/vim-polyglot",
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		event = "InsertCharPre",
		priority = 1000,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()

			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

			vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
		end,
	},
	{
		"https://github.com/kana/vim-textobj-user",
	},
	{
		"https://github.com/kana/vim-operator-user",
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"monaqa/dial.nvim",
		config = function()
			vim.keymap.set("n", "<C-a>", function()
				require("dial.map").manipulate("increment", "normal")
			end)
			vim.keymap.set("n", "<C-x>", function()
				require("dial.map").manipulate("decrement", "normal")
			end)
			vim.keymap.set("n", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gnormal")
			end)
			vim.keymap.set("n", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gnormal")
			end)
			vim.keymap.set("v", "<C-a>", function()
				require("dial.map").manipulate("increment", "visual")
			end)
			vim.keymap.set("v", "<C-x>", function()
				require("dial.map").manipulate("decrement", "visual")
			end)
			vim.keymap.set("v", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gvisual")
			end)
			vim.keymap.set("v", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gvisual")
			end)
		end,
	},
}
