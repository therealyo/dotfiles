return {
	"folke/trouble.nvim",

	config = function()
		local win = {
			type = "split", -- split window
			relative = "win", -- relative to current window
			position = "right", -- right side
			size = 0.25, -- 25% of the window
		}
		local bottom_win = vim.tbl_extend("force", win, { position = "bottom" })

		require("trouble").setup({
			modes = {
				lsp = { win = win },
				symbols = { win = win }, -- Configure symbols mode
				diagnostics = { win = bottom_win },
				quickfix = { win = bottom_win },
			},
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = desc })
		end

		map("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
		map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
		map("<leader>cs", "<cmd>Trouble symbols toggle<cr>", "Symbols (Trouble)")
		map("<leader>cS", "<cmd>Trouble lsp toggle<cr>", "LSP references/definitions/... (Trouble)")
		map("<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)")
		map("<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)")

		map("[q", function()
			if require("trouble").is_open() then
				require("trouble").prev({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cprev)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end, "Previous Trouble/Quickfix Item")

		map("]q", function()
			if require("trouble").is_open() then
				require("trouble").next({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cnext)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end, "Next Trouble/Quickfix Item")
	end,
}
