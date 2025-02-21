return {
	-- Faster escape from insert mode with jk
	{
		"nvim-zh/better-escape.vim",
	},
	-- Multi line select
	{
		"mg979/vim-visual-multi",
		config = function()
			vim.keymap.set("n", "<C-k>", "<Plug>(VM-Add-Cursor-Up)")
			vim.keymap.set("n", "<C-j>", "<Plug>(VM-Add-Cursor-Down)")
		end,
	},
}
