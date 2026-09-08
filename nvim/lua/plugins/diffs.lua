-- Diff review: `:Diffs` / `:DiffsReview`. Configured through `vim.g.diffs`,
-- which is read by the plugin's own `plugin/` file, so it must be set here
-- (init.lua runs before `plugin/` files are sourced).
--
-- NOTE: overlaps with diffview.nvim, which brings its own diff highlighting
-- and conflict-resolution UI. See plugins/diffview.lua.
return {
	"barrettruth/diffs.nvim",

	config = function()
		vim.g.diffs = {
			integrations = {
				fugitive = true,
				gitsigns = true,
				neogit = false,
				neojj = false,
			},
		}
	end,
}
