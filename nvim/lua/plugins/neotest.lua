return {
	"nvim-neotest/neotest",
	"nvim-neotest/nvim-nio",
	"nvim-lua/plenary.nvim",
	"antoinemadec/FixCursorHold.nvim",

	-- Adapters
	"nvim-neotest/neotest-plenary",
	"nvim-neotest/neotest-python",
	"olimorris/neotest-rspec",
	"olimorris/neotest-phpunit",
	"jfpedroza/neotest-elixir",
	-- { src = "therealyo/neotest-zig", version = "zig_0_15" },

	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-elixir"),

				require("neotest-rspec"),
				require("neotest-phpunit"),
				-- Re-enable together with the neotest-zig spec above.
				-- require("neotest-zig")({
				-- 	dap = {
				-- 		adapter = "lldb",
				-- 	},
				-- }),
			},
			-- consumers = {
			-- 	overseer = require("neotest.consumers.overseer"),
			-- },
			diagnostic = {
				enabled = false,
			},
			log_level = vim.log.levels.TRACE,
			icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",

				passed = "",
				running = "",
				failed = "",
				unknown = "",
				skipped = "",
			},
			floating = {
				border = "single",
				max_height = 0.8,
				max_width = 0.9,
			},
			summary = {
				mappings = {
					attach = "a",
					expand = { "<CR>", "<2-LeftMouse>" },
					expand_all = "e",
					jumpto = "i",
					output = "o",
					run = "r",
					short = "O",
					stop = "u",
				},
			},
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Neotest: " .. desc })
		end

		map("<LocalLeader>tn", function()
			require("neotest").run.run()
		end, "Test nearest")

		map("<LocalLeader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, "Test file")

		map("<LocalLeader>tl", function()
			require("neotest").run.run_last()
		end, "Run last test")

		map("<LocalLeader>ts", function()
			local neotest = require("neotest")
			for _, adapter_id in ipairs(neotest.run.adapters()) do
				neotest.run.run({ suite = true, adapter = adapter_id })
			end
		end, "Test suite")

		map("<LocalLeader>to", function()
			require("neotest").output.open({ short = true })
		end, "Open test output")

		map("<LocalLeader>twn", function()
			require("neotest").watch.toggle()
		end, "Watch nearest test")

		map("<LocalLeader>twf", function()
			require("neotest").watch.toggle({ vim.fn.expand("%") })
		end, "Watch file")

		map("<LocalLeader>twa", function()
			require("neotest").watch.toggle({ suite = true })
		end, "Watch all tests")
	end,
}
