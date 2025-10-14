return {
	"petertriho/nvim-scrollbar",
	event = "BufReadPre",
	config = function()
		-- Load Catppuccin Frappe colors
		-- local colors = require("catppuccin.palettes").get_palette("frappe")

		-- Scrollbar setup using Catppuccin Frappe colors
		require("scrollbar").setup({
			-- handle = {
			-- 	color = colors.surface0, -- Example handle color from Catppuccin Frappe
			-- },
			-- marks = {
			-- 	Search = { color = colors.peach }, -- Peach color for search highlights
			-- 	Error = { color = colors.red }, -- Red for errors
			-- 	Warn = { color = colors.yellow }, -- Yellow for warnings
			-- 	Info = { color = colors.blue }, -- Blue for info
			-- 	Hint = { color = colors.teal }, -- Teal for hints
			-- 	Misc = { color = colors.mauve }, -- Mauve for miscellaneous marks
			-- },
		})
	end,
}
