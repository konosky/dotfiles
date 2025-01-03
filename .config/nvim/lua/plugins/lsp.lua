return {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					if server_name == "lua_ls" then
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									workspace = {
										library = { vim.env.VIMRUNTIME },
									},
								},
							},
						})
						return
					end
					require("lspconfig")[server_name].setup({})

					local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
					vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
						default_handler(err, result, ctx, config)

						local diagnostics = result.diagnostics
						local bufnr = vim.uri_to_bufnr(result.uri)

						local qflist = {}
						for _, diagnostic in ipairs(diagnostics) do
							local start = diagnostic.range.start
							table.insert(qflist, {
								bufnr = bufnr,
								lnum = start.line + 1,
								col = start.character + 1,
								text = diagnostic.message,
								type = diagnostic.severity,
							})
						end

						vim.fn.setqflist(qflist, "r")
					end
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			local cmp = require("cmp")

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end
			cmp.setup({
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
				window = {},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline({ ":" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"biome",
				"black",
				"csharp-language-server",
				"csharpier",
				"dockerfile-language-server",
				"emmet-language-server",
				"hadolint",
				"lua-language-server",
				"pyright",
				"stylua",
				"yaml-language-server",
				"yamlfmt",
				"yamllint",
			},
		},
	},
}
