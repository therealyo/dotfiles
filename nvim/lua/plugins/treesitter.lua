return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"elixir",
				"eex",
				"heex",
				"go",
				"erlang",
				"ruby",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = "InsertEnter",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				endwise = {
					enable = true,
				},
			})
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {
			extension = {
				patterns = {
					ruby = {
						[[class= "([^"]*)]],
						[[class: "([^"]*)]],
						[[class= '([^"]*)]],
						[[class: '([^"]*)]],
						'~H""".*class="([^"]*)".*"""',
						'~F""".*class="([^"]*)".*"""',
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = function()
			local tsc = require("treesitter-context")

			local function toggle_treesitter_context()
				if tsc.is_enabled() then
					tsc.disable()
					print("Treesitter Context disabled")
				else
					tsc.enable()
					print("Treesitter Context enabled")
				end
			end

			-- Map the keybinding to toggle Treesitter context
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ut",
				"<cmd>lua toggle_treesitter_context()<CR>",
				{ noremap = true, silent = true, desc = "Toggle Treesitter Context" }
			)

			return { mode = "cursor", max_lines = 3 }
		end,
	},
}
