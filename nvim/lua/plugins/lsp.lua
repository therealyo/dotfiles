return {
	-- Main LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Callback function for LSP events
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local rename = function()
						vim.lsp.buf.rename()
						-- save all buffers after rename
						vim.cmd("silent! wa")
					end

					-- LSP Keybindings
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>rn", rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Inlay Hints toggle if supported
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP capabilities for autocompletion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local home = vim.loop.os_homedir()

			-- LSP server configurations
			local servers = {
				svelte = {},
				yamlls = {},
				eslint = {},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod" },
					root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
						},
					},
				},
				emmet_ls = {
					filetypes = {
						"astro",
						"css",
						"eruby",
						"html",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"svelte",
						"typescriptreact",
						"vue",
						"heex",
					},
				},
				pyright = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								diagnosticSeverityOverrides = {
									reportUnusedExpression = "none",
								},
							},
						},
					},
				},
				rust_analyzer = {},
				elixirls = {
					cmd = { home .. "/lsp/elixirls/language_server.sh" },
					settings = {
						dialyzerEnabled = true,
						fetchDeps = false,
						enableTestLenses = false,
						suggestSpecs = false,
					},
				},
				dockerls = {},
				erlangls = {},
				ruby_lsp = { enabled = true },
				ts_ls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				tailwindcss = {
					filetypes = {
						"aspnetcorerazor",
						"astro",
						"blade",
						"clojure",
						"django-html",
						"svelte",
						"eelixir",
						"elixir",
						"erb",
						"eruby",
						"html",
						"javascript",
						"ruby",
						"typescript",
						"vue",
					},
					settings = {
						tailwindCSS = {
							includeLanguages = {
								ruby = "erb",
								eelixir = "html-eex",
								heex = "html-eex",
								eruby = "erb",
							},
							experimental = {
								classRegex = {
									[[class:\s*["']([^"']*)["']],
									[[class= "([^"]*)]],
									[[class: "([^"]*)]],
									[[class= '([^']*)]],
									[[class: '([^']*)]],
									'~H""".*class="([^"]*)".*"""',
									'~F""".*class="([^"]*)".*"""',
								},
							},
						},
					},
				},
			}

			-- Mason setup for managing LSPs and tools
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" }) -- Add stylua for Lua formatting
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Setup servers using Mason LSPConfig
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	-- {
	-- 	"VidocqH/lsp-lens.nvim",
	-- 	config = function()
	-- 		require("lsp-lens").setup({})
	-- 	end,
	-- },
}
