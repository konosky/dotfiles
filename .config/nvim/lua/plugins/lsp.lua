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
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
				window = {},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
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
				"csharp-language-server",
				"csharpier",
				"emmet-language-server",
				"lua-language-server",
				"pyright",
				"stylua",
			},
		},
	},
}
