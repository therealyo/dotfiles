return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			integrations = {
				bufferline = true, -- Enable bufferline integration
			},
		})
	end,
}
