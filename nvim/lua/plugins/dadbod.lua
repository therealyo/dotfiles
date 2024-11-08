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
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		config = function()
			vim.keymap.set("n", "<leader>DB", "<cmd>tabnew<cr><cmd>DBUI<cr>", { desc = "Open [DB] UI" })
		end,
	},
}
