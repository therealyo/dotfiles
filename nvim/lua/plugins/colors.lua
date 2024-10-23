return {
	{
		"zaldih/themery.nvim",
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "Gruvbox Dark",
						colorscheme = "gruvbox",
						before = [[
              vim.opt.background = "dark"
            ]],
					},
					{
						name = "Gruvbox Light",
						colorscheme = "gruvbox",
						before = [[
              vim.opt.background = "light"
            ]],
					},

					-- Catppuccin configurations (Macchiato, Frappe, Latte, Mocha)
					{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
					{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
					{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
					{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },

					-- Kanagawa configurations (Lotus, Dragon)
					{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					{ name = "Kanagawa", colorscheme = "kanagawa" },

					-- GitHub configurations (Dark, Light, Dimmed)
					{ name = "GitHub Dark", colorscheme = "github_dark" },
					{ name = "GitHub Light", colorscheme = "github_light" },
					{ name = "GitHub Dimmed", colorscheme = "github_dark_dimmed" },

					-- Solarized configurations (Dark, Light)
					{ name = "Solarized Dark", colorscheme = "solarized8" },
					{ name = "Solarized Light", colorscheme = "solarized8_light" },

					-- Dracula
					{ name = "Dracula", colorscheme = "dracula" },

					-- One Dark and One Light
					{ name = "One Dark", colorscheme = "onedark" },
					{ name = "One Light", colorscheme = "onelight" },

					-- Ayu configurations (Dark, Light)
					{ name = "Ayu Dark", colorscheme = "ayu-dark" },
					{ name = "Ayu Light", colorscheme = "ayu-light" },

					-- Nord
					{ name = "Nord", colorscheme = "nord" },

					-- Tokyo Night configurations
					{ name = "Tokyo Night", colorscheme = "tokyonight" },
					{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
					{ name = "Tokyo Night Light", colorscheme = "tokyonight-light" },

					-- Edge configurations (Dark, Light)
					{ name = "Edge Dark", colorscheme = "edge" },
					{ name = "Edge Light", colorscheme = "edge_light" },

					-- Additional themes
					{ name = "PaperColor Light", colorscheme = "PaperColor" },
					{ name = "Molokai", colorscheme = "molokai" },
					{ name = "Gruvbox Material", colorscheme = "gruvbox-material" },
				},

				-- Enable live preview while selecting themes
				livePreview = true,
			})
		end,
	},

	-- Add the colorscheme repositories needed for the themes
	{ "rafi/awesome-vim-colorschemes" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.15,
			},
		},
	},
	{ "rebelot/kanagawa.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{ "folke/tokyonight.nvim" },
}
