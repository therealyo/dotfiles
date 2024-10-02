return {
	"stevearc/aerial.nvim",
	config = function()
		require("aerial").setup({
			-- Automatically open Aerial when entering supported buffers.
			-- The "supported" buffers are those that contain symbols Aerial can track.
			manage_folds = true, -- Enable folding based on Aerial symbols
			layout = {
				default_direction = "right", -- Show Aerial window on the right side by default
				min_width = 30, -- Minimum width of the Aerial window
			},
			-- Keymaps are set up separately in a function below.
		})

		-- Define key mappings with documentation
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { desc = "Aerial: " .. desc })
		end

		-- Key Mappings for Aerial with Documentation

		-- Toggle the Aerial window.
		-- This will open or close the Aerial window, which displays symbols in the current buffer.
		map("<leader>o", "<cmd>AerialToggle!<CR>", "Toggle Aerial", "n")

		-- Navigate to the symbol above the current one.
		-- This moves your cursor to the previous symbol in the Aerial window.
		map("{", "<cmd>AerialPrev<CR>", "Go to Previous Symbol", "n")

		-- Navigate to the symbol below the current one.
		-- This moves your cursor to the next symbol in the Aerial window.
		map("}", "<cmd>AerialNext<CR>", "Go to Next Symbol", "n")

		-- Close the Aerial window.
		-- This closes the Aerial window but keeps the content buffer open.
		map("<leader>oc", "<cmd>AerialClose<CR>", "Close Aerial", "n")

		-- Open the Aerial window.
		-- This opens the Aerial window to display the outline of the current file.
		map("<leader>oo", "<cmd>AerialOpen<CR>", "Open Aerial", "n")

		-- Focus on the Aerial window.
		-- This moves the cursor to the Aerial window without closing the content buffer.
		map("<leader>of", "<cmd>AerialFocus<CR>", "Focus on Aerial", "n")

		-- Refresh the Aerial window.
		-- This updates the symbols in the Aerial window based on the latest buffer content.
		map("<leader>or", "<cmd>AerialRefresh<CR>", "Refresh Aerial", "n")
	end,
}
