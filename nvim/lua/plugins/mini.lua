-- Collection of various small independent plugins/modules
return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	"echasnovski/mini.nvim",

	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()
		local zoom = function()
			require("mini.misc").zoom()
			if vim.api.nvim_win_get_config(0).relative == "" then
				return
			end
			vim.wo.winhighlight = "NormalFloat:Normal"
		end
		vim.keymap.set("n", "<Leader>z", zoom, { desc = "Zoom" })

		-- Comment plugin as comment.nvim is not maintained for a long time
		require("mini.comment").setup({
			-- Options which control module behavior
			options = {
				-- Function to compute custom 'commentstring' (optional)
				custom_commentstring = function()
					print("calculate commentstring", require("ts_context_commentstring").calculate_commentstring())
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,

				-- Whether to ignore blank lines in actions and textobject
				ignore_blank_line = false,

				-- Whether to recognize as comment only lines without indent
				start_of_line = false,

				-- Whether to force single space inner padding for comment parts
				pad_comment_parts = true,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Toggle comment on visual selection
				comment_visual = "gc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "gc",
			},

			-- Hook functions to be executed at certain stage of commenting
			hooks = {
				-- Before successful commenting. Does nothing by default.
				pre = function() end,
				-- After successful commenting. Does nothing by default.
				post = function() end,
			},
		})
	end,
}
