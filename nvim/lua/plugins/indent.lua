return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		char = "┆", -- You can change this to a subtler character like "|" or "┆"
		show_trailing_blankline_indent = false, -- Disable showing indent in trailing blanklines
		show_first_indent_level = true,
		use_treesitter = true, -- Enable Treesitter integration for better context-aware indentation
		show_current_context = true, -- Show current context (optional)
		show_current_context_start = true,
		char_highlight_list = {
			"IndentBlanklineChar1", -- Define custom highlights for different indent levels
			"IndentBlanklineChar2",
			"IndentBlanklineChar3",
			"IndentBlanklineChar4",
			"IndentBlanklineChar5",
		},
		context_highlight_list = {
			"IndentBlanklineContextChar1", -- Highlight for the current context indent
		},
	},
	config = function()
		-- Set the highlighting colors
		vim.api.nvim_set_hl(0, "IndentBlanklineChar1", { fg = "#3b4048" })
		vim.api.nvim_set_hl(0, "IndentBlanklineChar2", { fg = "#4b515a" })
		vim.api.nvim_set_hl(0, "IndentBlanklineChar3", { fg = "#5c626b" })
		vim.api.nvim_set_hl(0, "IndentBlanklineChar4", { fg = "#6c727c" })
		vim.api.nvim_set_hl(0, "IndentBlanklineChar5", { fg = "#7c828c" })
		vim.api.nvim_set_hl(0, "IndentBlanklineContextChar1", { fg = "#9d79d6", bold = true })

		-- Initialize the plugin with the specified options
		require("ibl").setup({
			-- Include the options from above
		})
	end,
}
