return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
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
				always_show_bufferline = true,
				themable = true,

				-- diagnostics = "nvim_lsp",
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 	local icon = level:match("error") and "" or (level:match("warning") and "" or "")
				-- 	return " " .. icon .. " " .. count
				-- end,

				-- Shift bufferline when NvimTree is open
				-- offsets = {
				-- 	{
				-- 		filetype = "NvimTree",
				-- 		text = "File Explorer",
				-- 		highlight = "Directory",
				-- 		text_align = "center",
				-- 		separator = true,
				-- 	},
				-- },
			},
		})
	end,
}
