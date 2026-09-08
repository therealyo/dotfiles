return {
	"sphamba/smear-cursor.nvim",

	config = function()
		require("smear_cursor").setup({
			stiffness = 0.5,
			trailing_stiffness = 0.49,
		})
	end,
}
