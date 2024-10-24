return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				-- theme = "github_dark", -- Setting GitHub dark theme
				theme = "catpuccin-frappe",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						require("noice").api.status.message.get_hl,
						cond = require("noice").api.status.message.has,
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#ff9e64" },
					},
					"filetype",
				},

				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
