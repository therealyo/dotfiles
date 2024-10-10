return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	config = function()
		require("diffview").setup({
			use_icons = true, -- Enable icons for better UI
			signs = {
				fold_closed = "",
				fold_open = "",
			},
			view = {
				default = {
					layout = "diff2_horizontal", -- Two-pane diff layout
				},
			},
		})

		vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
		vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
		vim.keymap.set("n", "<leader>df", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle Diffview Files" })
		vim.keymap.set("n", "<leader>dp", "<cmd>DiffviewFocusFiles<CR>", { desc = "Focus Diffview Files" })
	end,
}
