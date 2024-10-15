return {
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("github_dark_dimmed")
			require("github-theme").setup({
				options = {
					transparent = false,
					dim_inactive = true,
					modules = {
						-- dashboard = true,
						fidget = true,
						indent_blankline = true,
						gitsigns = true,
						nvimtree = true,
						telescope = true,
						whichkey = true,
					},
				},
			})
		end,
	},
}
