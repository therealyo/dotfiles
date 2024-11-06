return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})

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
				always_show_bufferline = false,
				themable = true,
			},
		})
	end,
}
