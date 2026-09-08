return {
	-- `main` is the rewritten branch; parsers are installed explicitly below.
	{ src = "nvim-treesitter/nvim-treesitter", version = "main" },
	"nvim-treesitter/nvim-treesitter-context",

	config = function()
		require("nvim-treesitter").setup()

		-- On the `main` branch this list is not consumed by setup(); we must
		-- install parsers explicitly. Highlight/indent are also NOT auto-enabled
		-- here — that happens via the FileType autocmd in config/autocommands.lua
		-- (vim.treesitter.start), which is what makes context_commentstring work.
		require("nvim-treesitter").install({
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"elixir",
			"eex",
			"heex",
			"go",
			"erlang",
			"ruby",
			"tsx",
			"typescript",
			"toml",
			"fish",
			"php",
			"json",
			"yaml",
			"swift",
			"css",
			"python",
			"javascript",
			"svelte",
		})

		local tsc = require("treesitter-context")
		tsc.setup({ mode = "cursor", max_lines = 3 })

		vim.keymap.set("n", "<leader>ut", function()
			if tsc.enabled() then
				tsc.disable()
				print("Treesitter Context disabled")
			else
				tsc.enable()
				print("Treesitter Context enabled")
			end
		end, { noremap = true, silent = true, desc = "Toggle Treesitter Context" })
	end,
}
