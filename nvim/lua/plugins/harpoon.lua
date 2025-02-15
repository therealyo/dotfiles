return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "[A]ncore" })

		vim.keymap.set("n", "<leader>sa", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[S]earch [a]ncore" })

		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { desc = "Go to Harpoon mark " .. i })
		end
	end,
}
