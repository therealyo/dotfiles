local vault_default_name = "therealyo"
local vault_path = "~/vaults/" .. vault_default_name

return {
	-- `version` follows the latest release instead of the default branch.
	{ src = "epwalsh/obsidian.nvim", version = vim.version.range("*") },
	"nvim-lua/plenary.nvim",

	config = function()
		-- setup() reads the workspace from disk and throws if it is missing.
		-- Under lazy.nvim this only ran on opening a note, so skip it when
		-- there is no vault on this machine.
		if vim.fn.isdirectory(vim.fn.expand(vault_path)) == 0 then
			return
		end

		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = vault_path,
				},
			},
		})
	end,
}
