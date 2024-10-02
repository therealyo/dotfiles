return {
	"rebelot/heirline.nvim",
	event = "User BaseDefered",
	opts = function()
		-- Define the colors and highlights directly here
		local colors = {
			black = "#282c34", -- Background color
			fg1 = "#c9d1d9", -- Foreground color
			grey0 = "#7c7c7c", -- Light gray
			grey1 = "#6e7681", -- Darker gray
			blue = "#58a6ff", -- Blue highlights
			green = "#56d364", -- Green highlights
			orange = "#d29922", -- Orange
			purple = "#8957e5", -- Purple for git branches
			red = "#f85149", -- Red for errors
			yellow = "#d29922", -- Warnings
			aqua = "#39c5cf", -- Hints/info
		}

		-- Define highlights based on the colors
		local hl = {
			StatusLine = { fg = colors.fg1, bg = colors.black },
			WinBar = { fg = colors.fg1 },
			Tabline = { fg = colors.grey0, bg = colors.black },
			TablineActive = { fg = colors.blue },
			TablineInactive = { fg = colors.grey1 },
			LspServer = { fg = colors.blue, bold = true },
			Git = {
				branch = { fg = colors.purple, bold = true },
				added = { fg = colors.green },
				changed = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			Diagnostic = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.aqua },
				hint = { fg = colors.aqua },
			},
			Mode = setmetatable({
				normal = { fg = colors.fg1 },
			}, {
				__index = function(_, mode)
					return {
						fg = colors.black,
						bg = colors[mode] or colors.fg1, -- Default to fg1 if mode not found
						bold = true,
					}
				end,
			}),
		}

		-- Define your custom components (Lsp, Git, FileInfo, etc.)
		local Lsp = {
			condition = require("heirline.conditions").lsp_attached,
			init = function(self)
				local clients = {}
				for _, client in pairs(vim.lsp.get_active_clients()) do
					table.insert(clients, client.name)
				end
				self.clients = clients
			end,
			provider = function(self)
				return " [" .. table.concat(self.clients, ", ") .. "] "
			end,
			hl = hl.LspServer,
		}

		local Git = {
			condition = require("heirline.conditions").is_git_repo,
			init = function(self)
				self.status = vim.b.gitsigns_status_dict
			end,
			{
				provider = function(self)
					return " " .. self.status.head .. " "
				end,
				hl = hl.Git.branch,
			},
			{
				provider = function(self)
					local added = self.status.added or 0
					if added > 0 then
						return "+" .. added .. " "
					end
				end,
				hl = hl.Git.added,
			},
			{
				provider = function(self)
					local changed = self.status.changed or 0
					if changed > 0 then
						return "~" .. changed .. " "
					end
				end,
				hl = hl.Git.changed,
			},
			{
				provider = function(self)
					local removed = self.status.removed or 0
					if removed > 0 then
						return "-" .. removed .. " "
					end
				end,
				hl = hl.Git.removed,
			},
		}

		local FileInfo = {
			init = function(self)
				self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
				self.extension = vim.fn.fnamemodify(self.filename, ":e")
				self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(self.filename, self.extension)
				if not self.icon then
					self.icon = ""
					self.icon_color = "#6d8086"
				end
			end,
			provider = function(self)
				return self.icon .. " " .. self.filename .. " "
			end,
			hl = function(self)
				return { fg = self.icon_color, bold = true }
			end,
		}

		local Diagnostics = {
			condition = require("heirline.conditions").has_diagnostics,
			static = {
				error_icon = " ",
				warn_icon = " ",
				info_icon = " ",
				hint_icon = " ",
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			{
				provider = function(self)
					if self.errors > 0 then
						return self.error_icon .. self.errors .. " "
					end
				end,
				hl = hl.Diagnostic.error,
			},
			{
				provider = function(self)
					if self.warnings > 0 then
						return self.warn_icon .. self.warnings .. " "
					end
				end,
				hl = hl.Diagnostic.warn,
			},
			{
				provider = function(self)
					if self.infos > 0 then
						return self.info_icon .. self.infos .. " "
					end
				end,
				hl = hl.Diagnostic.info,
			},
			{
				provider = function(self)
					if self.hints > 0 then
						return self.hint_icon .. self.hints .. " "
					end
				end,
				hl = hl.Diagnostic.hint,
			},
		}

		-- Return the full Heirline configuration
		return {
			opts = {
				disable_winbar_cb = function(args)
					local disabled_filetypes = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" }
					local buf_type = vim.bo[args.buf].buftype
					for _, ft in ipairs(disabled_filetypes) do
						if string.match(buf_type, ft) then
							return true
						end
					end
					return false
				end,
			},
			statusline = {
				hl = hl.StatusLine,

				-- Mode section
				{
					provider = function()
						local mode = vim.fn.mode()
						return " " .. mode .. " "
					end,
					hl = function()
						local mode_colors = hl.Mode
						local mode = vim.fn.mode():sub(1, 1)
						return mode_colors[mode] or mode_colors.normal
					end,
				},

				-- Separator
				{ provider = " | ", hl = { fg = hl.StatusLine.separator } },

				-- File Info
				FileInfo,

				-- Diagnostics
				Diagnostics,

				-- Git Info
				Git,

				-- LSP Info
				Lsp,

				-- Scroll and Line/Column info
				{
					provider = function()
						return string.format(" %d%% ", vim.fn.line(".") * 100 / vim.fn.line("$"))
					end,
					hl = { fg = hl.StatusLine.fg, bold = true },
				},
				{
					provider = "%l:%c", -- Line and column number
					hl = { fg = hl.StatusLine.fg, bold = true },
				},
			},
		}
	end,
	config = function(_, opts)
		local heirline = require("heirline")

		-- Setup colors and components
		heirline.load_colors(colors)
		heirline.setup(opts)
	end,
}
