return {
	"windwp/nvim-ts-autotag",
	opts = {},
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			per_filetype = {
				["html"] = {
					enable_close = true,
				},
			},
			aliases = {
				["eruby"] = "html",
				["heex"] = "html",
				["ex"] = "html",
			},
		})
	end,
}
