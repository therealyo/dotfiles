local function find_project_root()
	---@type string
	local current_dir = vim.uv.cwd()
	local marker_files = { ".git" }

	-- Check each parent directory for the existence of a marker file or directory
	while current_dir ~= "/" do
		for _, marker in ipairs(marker_files) do
			local marker_path = current_dir .. "/" .. marker
			if vim.fn.isdirectory(marker_path) == 1 or vim.fn.filereadable(marker_path) == 1 then
				return current_dir
			end
		end
		current_dir = vim.fn.resolve(current_dir .. "/..")
	end
	-- If no marker file or directory is found, return the original directory
	return vim.uv.cwd()
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			cwd = {
				get_root_dir = function()
					print(find_project_root())
					return find_project_root()
				end,
			},
		})
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
