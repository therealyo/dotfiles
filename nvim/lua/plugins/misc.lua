return {
	-- faster escape from instert mode using jj
	{
		"TheBlob42/houdini.nvim",
		config = function()
			require("houdini").setup({
				mappings = { "jj" },
			})
		end,
	},
}
