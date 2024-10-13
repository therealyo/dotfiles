return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		require("smart-splits").setup({
			ignored_buftypes = { "nofile", "quickfix", "prompt" },
			ignored_filetypes = { "NvimTree" },
			default_amount = 3,
			at_edge = "wrap",
			float_win_behavior = "previous",
			move_cursor_same_row = false,
			resize_mode = {
				quit_key = "<ESC>",
				resize_keys = { "h", "j", "k", "l" },
				silent = false,
				hooks = {
					on_enter = function()
						vim.notify("Entering resize mode")
					end,
					on_leave = function()
						vim.notify("Exiting resize mode")
					end,
				},
			},
		})

		-- Key mappings for smart-splits.nvim
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { desc = "Smart Splits: " .. desc })
		end

		-- Resizing splits
		map("<A-h>", require("smart-splits").resize_left, "Resize window to the left")
		map("<A-j>", require("smart-splits").resize_down, "Resize window down")
		map("<A-k>", require("smart-splits").resize_up, "Resize window up")
		map("<A-l>", require("smart-splits").resize_right, "Resize window to the right")

		-- Moving between splits
		map("<C-h>", require("smart-splits").move_cursor_left, "Move to left window")
		map("<C-j>", require("smart-splits").move_cursor_down, "Move to window below")
		map("<C-k>", require("smart-splits").move_cursor_up, "Move to window above")
		map("<C-l>", require("smart-splits").move_cursor_right, "Move to right window")
		-- map("<C-\\>", require("smart-splits").move_cursor_previous, "Move to previous window")

		-- Swapping buffers between windows
		map("<leader><leader>h", require("smart-splits").swap_buf_left, "Swap buffer with window on the left")
		map("<leader><leader>j", require("smart-splits").swap_buf_down, "Swap buffer with window below")
		map("<leader><leader>k", require("smart-splits").swap_buf_up, "Swap buffer with window above")
		map("<leader><leader>l", require("smart-splits").swap_buf_right, "Swap buffer with window on the right")

		-- Creating horizontal and vertical splits
		map("<leader>sh", ":split<CR>", "Create horizontal split")
		map("<leader>sv", ":vsplit<CR>", "Create vertical split")
	end,
}
