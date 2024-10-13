return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- Trigger loading before reading buffers
	config = function()
		require("persistence").setup({
			dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Directory where sessions are saved
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- Session options
		})
		-- load the session for the current directory
		vim.keymap.set("n", "<leader>qs", function()
			require("persistence").load()
		end)

		-- select a session to load
		vim.keymap.set("n", "<leader>qS", function()
			require("persistence").select()
		end)

		-- load the last session
		vim.keymap.set("n", "<leader>ql", function()
			require("persistence").load({ last = true })
		end)

		-- stop Persistence => session won't be saved on exit
		vim.keymap.set("n", "<leader>qd", function()
			require("persistence").stop()
		end)
	end,
}
