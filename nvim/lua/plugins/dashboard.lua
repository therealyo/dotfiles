return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	opts = function()
		local logo = [[
	    ██╗     ██████╗  ███╗   ███╗ ███╗   ███╗
	    ██║    ██╔════╝  ████╗ ████║ ████╗ ████║
	    ██║    ██║ ████║ ██╔████╔██║ ██╔████╔██║
	    ██║    ██║   ██║ ██║╚██╔╝██║ ██║╚██╔╝██║
	    ██████╗╚███████║ ██║ ╚═╝ ██║ ██║ ╚═╝ ██║
	    ╚═════╝ ╚══════╝ ╚═╝     ╚═╝ ╚═╝     ╚═╝
	 ]]

		local github_and_date = "🚀 GitHub: https://github.com/therealyo  |  📅 Date: " .. os.date("%Y-%m-%d")

		local header = vim.split("\n\n\n" .. logo .. "\n\n" .. github_and_date .. "\n\n", "\n")

		local opts = {
			theme = "doom",
			hide = {
				tabline = false,
				statusline = false, -- handled by lualine or your chosen statusline plugin
			},
			config = {
				header = header,
				center = {
					{
						action = "Telescope find_files",
						desc = " Find File",
						icon = " ",
						key = "f",
					},
					{
						action = "ene | startinsert",
						desc = " New File",
						icon = " ",
						key = "n",
					},
					{
						action = function()
							require("telescope").extensions.projects.projects()
						end,
						desc = " Browse Projects",
						icon = "📂",
						key = "p",
					},
					{
						action = "Telescope oldfiles",
						desc = " Recent Files",
						icon = " ",
						key = "r",
					},
					{
						action = "Telescope live_grep",
						desc = " Find Text",
						icon = " ",
						key = "g",
					},
					{ action = "Telescope find_files cwd=~/.config/nvim", desc = " Config", icon = " ", key = "c" },
					{
						action = "Telescope",
						desc = " Telescope",
						icon = " ",
						key = "t",
					},
					{
						action = "Lazy",
						desc = " Lazy",
						icon = "󰒲 ",
						key = "l",
					},
					{
						action = function()
							vim.api.nvim_input("<cmd>qa<cr>")
						end,
						desc = " Quit",
						icon = " ",
						key = "q",
					},
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end

		return opts
	end,
}
