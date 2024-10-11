return {
	{
		"folke/edgy.nvim",
		lazy = false, -- Load on startup
		config = function()
			require("edgy").setup({
				animate = {
					enabled = false,
				},
				bottom = {
					{
						ft = "toggleterm",
						size = { height = 0.3 },
						filter = function(buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					-- {
					-- 	ft = "trouble",
					-- 	title = "Diagnosics",
					-- 	size = { height = 0.3 },
					-- },
					-- "Trouble",
					{
						ft = "qf", -- QuickFix list
						title = "QuickFix",
						size = { height = 0.3 },
					},
					{
						ft = "help",
						size = { height = 20 },
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
				},
				left = {
					{
						ft = "NvimTree", -- NvimTree for file explorer
						title = "File Explorer",
						size = { width = 0.15 },
					},
				},
				right = {
					{
						ft = "trouble",
						title = "Diagnostics",
						size = { width = 0.3 },
					},
				},
				keys = {
					["<A-l>"] = function(win)
						win:resize("width", 2)
					end,
					["<A-h>"] = function(win)
						win:resize("width", -2)
					end,
					["<A-k>"] = function(win)
						win:resize("height", 2)
					end,
					["<A-j>"] = function(win)
						win:resize("height", -2)
					end,
				},
			})

			-- Keybindings for toggling Edgy windows
			vim.keymap.set("n", "<leader>ue", function()
				require("edgy").toggle()
			end, { desc = "Toggle Edgy", noremap = true, silent = true })

			vim.keymap.set("n", "<leader>uE", function()
				require("edgy").select()
			end, { desc = "Select Edgy Window", noremap = true, silent = true })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = function()
			local Offset = require("bufferline.offset")
			if not Offset.edgy then
				local get = Offset.get
				Offset.get = function()
					if package.loaded.edgy then
						local layout = require("edgy.config").layout
						local ret = { left = "", left_size = 0, right = "", right_size = 0 }
						for _, pos in ipairs({ "left", "right" }) do
							local sb = layout[pos]
							if sb and #sb.wins > 0 then
								local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
								ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
								ret[pos .. "_size"] = sb.bounds.width
							end
						end
						ret.total_size = ret.left_size + ret.right_size
						if ret.total_size > 0 then
							return ret
						end
					end
					return get()
				end
				Offset.edgy = true
			end
		end,
	},
}
