local function augroup(name)
	return vim.api.nvim_create_augroup("therealyo" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("DiffviewClose")
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	desc = "Prevent colorscheme clearing self-defined DAP marker colors",
	callback = function()
		-- Reuse current SignColumn background (except for DapStoppedLine)
		local sign_column_hl = vim.api.nvim_get_hl(0, { name = "SignColumn" })
		-- if bg or ctermbg aren't found, use bg = 'bg' (which means current Normal) and ctermbg = 'Black'
		-- convert to 6 digit hex value starting with #
		local sign_column_bg = (sign_column_hl.bg ~= nil) and ("#%06x"):format(sign_column_hl.bg) or "bg"
		local sign_column_ctermbg = (sign_column_hl.ctermbg ~= nil) and sign_column_hl.ctermbg or "Black"

		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e4d3d", ctermbg = "Green" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#c23127", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
		vim.api.nvim_set_hl(
			0,
			"DapBreakpointRejected",
			{ fg = "#888ca6", bg = sign_column_bg, ctermbg = sign_column_ctermbg }
		)
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
	end,
})

vim.cmd([[ set statusline=%f%=%{&filetype} ]])

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function(args)
		-- make_range_params() requires an explicit position encoding, so build
		-- the params per client instead of relying on a default.
		local clients = vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/codeAction" })
		for _, client in ipairs(clients) do
			local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
			params.context = { only = { "source.organizeImports" }, diagnostics = {} }
			-- Bump the timeout if a single write is not enough to apply the edits.
			local result = client:request_sync("textDocument/codeAction", params, 5000, args.buf)
			for _, r in pairs((result or {}).result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
