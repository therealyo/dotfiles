return {
	"folke/flash.nvim",

	config = function()
		require("flash").setup({})

		-- stylua: ignore start
		vim.keymap.set({ "n", "x", "o" }, "f", function() require("flash").jump() end, { desc = "[f]lash" })
		vim.keymap.set({ "n", "x", "o" }, "F", function() require("flash").treesitter() end, { desc = "[F]lash Treesitter" })
		vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "[R]emote Flash" })
		vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
		vim.keymap.set("n", "<C-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
		-- stylua: ignore end
	end,
}
