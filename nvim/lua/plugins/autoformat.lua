-- Autoformat
return {
	"stevearc/conform.nvim",

	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 2000,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters = {
				jq = {
					command = "jq",
					args = { "--indent", "4", "." },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt", "golines" },
				json = { "jq" },
				ruby = { "rubocop" },
				eruby = { "erb-format" },
				sh = { "shfmt" },

				html = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "[F]ormat buffer" })
	end,
}
