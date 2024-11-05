-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- vim.opt.termguicolors = true

return {
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		-- Enable 24-bit color
	-- 		vim.opt.termguicolors = true
	-- 		local api = require("nvim-tree.api")
	-- 		local function toggle_nvim_tree()
	-- 			if api.tree.is_visible() then
	-- 				api.tree.close()
	-- 			else
	-- 				api.tree.open()
	-- 			end
	-- 		end
	--
	-- 		vim.keymap.set("n", "<leader>e", toggle_nvim_tree, { noremap = true, silent = true })
	-- 		vim.keymap.set("n", "<leader>E", api.tree.focus, { noremap = true, silent = true })
	--
	-- 		-- Setup nvim-tree with the desired options
	-- 		require("nvim-tree").setup({
	-- 			sort_by = "case_sensitive",
	-- 			view = {
	-- 				width = 30,
	-- 			},
	-- 			renderer = {
	-- 				group_empty = true,
	-- 				highlight_git = true, -- Highlight git changes
	-- 				highlight_opened_files = "name", -- Highlight opened files
	-- 				indent_markers = {
	-- 					enable = true, -- Show indent markers
	-- 				},
	-- 				icons = {
	-- 					show = {
	-- 						git = true,
	-- 						folder = true,
	-- 						file = true,
	-- 					},
	-- 				},
	-- 			},
	-- 			filters = {
	-- 				dotfiles = false, -- Show dotfiles
	-- 			},
	-- 			sync_root_with_cwd = true,
	-- 			respect_buf_cwd = true,
	-- 			update_focused_file = {
	-- 				enable = true,
	-- 				update_root = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"mikavilpas/yazi.nvim",
		keys = {
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<leader>e",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
			floating_window_scaling_factor = 0.9,
		},
	},
}
