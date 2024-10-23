return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = " ▎" },
			change = { text = " ▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = " ▎" },
			untracked = { text = " ▎" },
		},
		signs_staged = {
			add = { text = " ▎" },
			change = { text = " ▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = " ▎" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			-- Define GitSigns keybindings with descriptions
			local map = function(mode, lhs, rhs, desc)
				vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
			end

			-- Keybindings for GitSigns
			map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Next Hunk")
			map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", "Previous Hunk")
			map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
			map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
			map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", "Stage Buffer")
			map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk")
			map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer")
			map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk")
			map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", "Blame Line")

			-- Highlight Definitions (remove deprecation warnings)
			vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
		end,
	},
}
