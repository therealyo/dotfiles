return {
	"nvimdev/dashboard-nvim",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
		})
	end,
}
