return {
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	"kristijanhusak/vim-dadbod-ui",

	config = function()
		require("cmp").setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})

		-- Read by vim-dadbod-ui's `plugin/` file, which is sourced after init.lua.
		vim.g.db_ui_use_nerd_fonts = 1

		vim.keymap.set("n", "<leader>DB", "<cmd>tabnew<cr><cmd>DBUI<cr>", { desc = "Open [DB] UI" })
	end,
}
