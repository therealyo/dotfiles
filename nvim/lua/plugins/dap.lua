return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({})

			-- Handled by nvim-dap-go
			-- dap.adapters.go = {
			--   type = "server",
			--   port = "${port}",
			--   executable = {
			--     command = "dlv",
			--     args = { "dap", "-l", "127.0.0.1:${port}" },
			--   },
			-- }

			local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
			if elixir_ls_debugger ~= "" then
				dap.adapters.mix_task = {
					type = "executable",
					command = elixir_ls_debugger,
				}

				dap.configurations.elixir = {
					{
						type = "mix_task",
						name = "phoenix server",
						task = "phx.server",
						request = "launch",
						projectDir = "${workspaceFolder}",
						exitAfterTaskReturns = false,
						debugAutoInterpretAllModules = false,
					},
				}
			end

			-- UI
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Go To [B]reakpoint" })

			-- Eval var under cursor
			vim.keymap.set("n", "<leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Eval var under cursor" })

			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Dap Continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Dap Step Into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Dap Step Over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Dap Step Out" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Dap Step Back" })
			vim.keymap.set("n", "<F13>", dap.restart, { desc = "Dap Restart" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- vim.highlight.create("DapBreakpoint", { ctermbg = 0, guifg = "#993939", guibg = "#31353f" }, false)
			-- vim.highlight.create("DapLogPoint", { ctermbg = 0, guifg = "#61afef", guibg = "#31353f" }, false)
			-- vim.highlight.create("DapStopped", { ctermbg = 0, guifg = "#98c379", guibg = "#31353f" }, false)
			--
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)
		end,
	},
}
