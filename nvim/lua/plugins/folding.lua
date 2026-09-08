-- Folding plugin
return {
	"kevinhwang91/nvim-ufo",
	"kevinhwang91/promise-async",

	-- Folding preview, by default h and l keys are used.
	-- On first press of h key, when cursor is on a closed fold, the preview will be shown.
	-- On second press the preview will be closed and fold will be opened.
	-- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
	"anuvyklack/fold-preview.nvim",
	"anuvyklack/keymap-amend.nvim",

	config = function()
		-- guh.nvim also ships a `lua/async.lua`, so `require("async")` resolves to
		-- whichever of the two comes first on 'runtimepath'. Bind the name to
		-- promise-async's module, which is the one nvim-ufo expects.
		for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/async.lua", true)) do
			if path:find("promise%-async") then
				package.loaded["async"] = loadfile(path)()
				break
			end
		end

		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})

		vim.keymap.set("n", "zR", function()
			require("ufo").openAllFolds()
		end)
		vim.keymap.set("n", "zM", function()
			require("ufo").closeAllFolds()
		end)

		require("fold-preview").setup()
	end,
}
