return {
	"akinsho/bufferline.nvim",
	config = function()
		require("bufferline").setup({
			options = {
				close_command = "bp|sp|bn|bd! %d",
				right_mouse_command = "bp|sp|bn|bd! %d",
				left_mouse_command = "buffer %d",
				buffer_close_icon = "x",
				modified_icon = "",
				close_icon = "x",
				show_close_icon = true,
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 14,
				max_prefix_length = 13,
				tab_size = 10,
				show_tab_indicators = true,
				indicator = {
					style = "underline",
				},
				enforce_regular_tabs = false,
				view = "multiwindow",
				show_buffer_close_icons = true,
				separator_style = "thin",
				always_show_bufferline = true,
				themable = true,

				-- diagnostics = "nvim_lsp",
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 	local icon = level:match("error") and "" or (level:match("warning") and "" or "")
				-- 	return " " .. icon .. " " .. count
				-- end,

				-- Shift bufferline when NvimTree is open
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
						separator = true,
					},
				},
			},

			-- Custom highlight colors to make bufferline dimmer than the editor background
			highlights = {
				-- This will set the background of the fill area (where there are no buffers)
				fill = {
					bg = "#30363D", -- Match the editor background color
				},
				background = {
					fg = "#b1bac4", -- Foreground color for inactive buffers
					bg = "#262b31", -- Slightly dimmed background for inactive buffers
				},
				-- Selected buffer/tab
				buffer_selected = {
					fg = "#e6edf3", -- Selected buffer foreground color
					bg = "#30363D", -- Background matching editor
					bold = true,
				},
				-- Tab highlight
				tab_selected = {
					fg = "#e6edf3", -- Active tab foreground color
					bg = "#30363D", -- Active tab background matching editor
				},
				-- This should fix the separators (left/right) to match the background color
				separator = {
					fg = "#30363D", -- Separator foreground color matching the editor background
					bg = "#262b31", -- Background for separators between buffers
				},
				separator_selected = {
					fg = "#30363D", -- Separator color next to selected buffer
					bg = "#30363D", -- Match the selected buffer background
				},
				-- Close buttons
				close_button = {
					fg = "#b1bac4", -- Foreground for close button
					bg = "#262b31", -- Background matching dimmed bufferline
				},
				close_button_selected = {
					fg = "#e6edf3", -- Close button foreground for selected buffer
					bg = "#30363D", -- Background matching active tab
				},
				-- This highlights the empty space when the bufferline is at the left or right edge
				indicator_selected = {
					fg = "#e6edf3", -- Indicator color for selected buffer
					bg = "#30363D", -- Background color for selected buffer
				},
			},
		})
	end,
}
