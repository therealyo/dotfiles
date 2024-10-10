return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup()
	end,
	opts = {}, -- for passing setup options
	-- this is equivalent to setup({}) function
}
