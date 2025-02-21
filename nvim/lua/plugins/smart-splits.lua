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

		-- recommended mappings
		-- resizing splits
		-- these keymaps will also accept a range,
		-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
		vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
		vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
		vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
		vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
		-- moving between splits
		vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
		vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
		-- swapping buffers between windows
		vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
		vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
		vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
		vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

		-- Creating horizontal and vertical splits
		map("<leader>sh", ":split<CR>", "Create horizontal split")
		map("<leader>sv", ":vsplit<CR>", "Create vertical split")
	end,
}
