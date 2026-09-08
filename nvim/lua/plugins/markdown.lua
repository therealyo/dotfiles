return {
	"MeanderingProgrammer/render-markdown.nvim",
	"nvim-treesitter/nvim-treesitter",
	"echasnovski/mini.nvim", -- if you use the mini.nvim suite

	config = function()
		---@module 'render-markdown'
		require("render-markdown").setup({})
	end,
}
