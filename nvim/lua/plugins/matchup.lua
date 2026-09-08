return {
	"andymass/vim-matchup",

	config = function()
		-- Read by vim-matchup's `plugin/` file, which is sourced after init.lua.
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
