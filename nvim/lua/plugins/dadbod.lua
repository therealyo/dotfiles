return {
	{
		"tpope/vim-dadbod",
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		config = function()
			local cmp = require("cmp")
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		config = function()
			vim.keymap.set("n", "<leader>DB", "<cmd>DBUI<cr>", { desc = "Open [DB] UI" })
		end,
	},
}
