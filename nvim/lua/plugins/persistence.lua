return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- Trigger loading before reading buffers
	config = function()
		require("persistence").setup({
			dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Directory where sessions are saved
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- Session options
		})

		-- Key mappings for session management
		vim.keymap.set("n", "<leader>qs", function()
			require("persistence").load()
		end, { desc = "Restore session for current dir" })
		vim.keymap.set("n", "<leader>ql", function()
			require("persistence").load({ last = true })
		end, { desc = "Restore last session" })
		vim.keymap.set("n", "<leader>qd", function()
			require("persistence").stop()
		end, { desc = "Stop persistence (Session saving)" })
	end,
}
