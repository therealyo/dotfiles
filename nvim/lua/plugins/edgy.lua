return {
	{
		"folke/edgy.nvim",
		lazy = false,
		keys = {
			{
				"<leader>ue",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
			{
				"<leader>uE",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
		},
		opts = function()
			local opts = {
				animate = {
					enabled = false,
				},
				bottom = {
					{
						ft = "toggleterm",
						size = { height = 0.2 },
						filter = function(buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					"Trouble",
					{
						ft = "qf", -- QuickFix list
						title = "QuickFix",
						size = { height = 0.2 },
					},
					{
						ft = "help",
						size = { height = 20 },
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
					{
						ft = "fugitive",
						title = "Git Status",
						size = { height = 0.2 },
					},
					{
						ft = "DiffviewFileHistory",
						title = "File History",
						size = { height = 0.3 },
					},
				},
				left = {
					{
						ft = "NvimTree", -- NvimTree for file explorer
						title = "File Explorer",
						size = { width = 0.2 },
					},
					{
						ft = "undotree", -- NvimTree for file explorer
						title = "Undotree",
						size = { width = 0.2 },
					},
					{
						ft = "diff", -- NvimTree for file explorer
						title = "Undotree diff",
						size = { width = 0.2 },
					},
					{
						ft = "DiffviewFiles", -- NvimTree for file explorer
						title = "Diff Files",
						size = { width = 0.2 },
					},
				},
				keys = {
					["<A-h>"] = function(win)
						win:resize("width", 2)
					end,
					["<A-l>"] = function(win)
						win:resize("width", -2)
					end,
					["<A-k>"] = function(win)
						win:resize("height", 2)
					end,
					["<A-j>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}
			--
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
				opts[pos] = opts[pos] or {}
				table.insert(opts[pos], {
					ft = "trouble",
					size = { height = 0.2, width = 0.2 },
					filter = function(_buf, win)
						return vim.w[win].trouble
							and vim.w[win].trouble.position == pos
							and vim.w[win].trouble.type == "split"
							and vim.w[win].trouble.relative == "editor"
							and not vim.w[win].trouble_preview
					end,
				})
			end

			return opts
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
