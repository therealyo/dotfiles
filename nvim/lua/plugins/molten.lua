return {
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"GCBallesteros/jupytext.nvim",
				config = true,
			},
		},
		config = function()
			require("quarto").setup({
				debug = false,
				closePreviewOnExit = true,
				lspFeatures = {
					enabled = true,
					chunks = "curly",
					languages = { "r", "python", "julia", "bash", "html" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				codeRunner = {
					enabled = false,
					default_method = "molten",
					ft_runners = {
						{ python = "molten" },
					},
					never_run = { "yaml" },
				},
			})
		end,
	},
	{
		"benlubas/molten-nvim",
		dependencies = {
			{
				"willothy/wezterm.nvim",
				config = true,
			},
		},
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_output_win_max_height = 12
			vim.g.molten_image_provider = "wezterm"
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
		config = function()
			vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "[M]olten [I]nit" })
			vim.keymap.set(
				"n",
				"<localleader>e",
				":MoltenEvaluateOperator<CR>",
				{ silent = true, desc = "run operator selection" }
			)
			vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
			vim.keymap.set(
				"n",
				"<localleader>mr",
				":MoltenReevaluateCell<CR>",
				{ silent = true, desc = "re-evaluate cell" }
			)
			vim.keymap.set(
				"v",
				"<localleader>mr",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, desc = "evaluate visual selection" }
			)
			local runner = require("quarto.runner")
			vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
			vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
			vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
			vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
			vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
			vim.keymap.set("n", "<localleader>RA", function()
				runner.run_all(true)
			end, { desc = "run all cells of all languages", silent = true })

			vim.keymap.set("n", "<localleader>ip", function()
				local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
				if venv ~= nil then
					-- in the form of /home/benlubas/.virtualenvs/VENV_NAME
					venv = string.match(venv, "/.+/(.+)")
					vim.cmd(("MoltenInit %s"):format(venv))
				else
					vim.cmd("MoltenInit python3")
				end
			end, { desc = "Initialize Molten for python3", silent = true })
		end,
	},
}
