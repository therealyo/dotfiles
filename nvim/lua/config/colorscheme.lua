-- Set TokyoNight as the active theme
-- vim.cmd("colorscheme rose-pine")

-- vim.cmd.colorscheme("github_dark_dimmed")
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

-- vim.cmd.colorscheme("catppuccin-frappe")
