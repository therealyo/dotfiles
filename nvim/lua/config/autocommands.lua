-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	desc = "Highlight when yanking (copying) text",
-- 	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- })
local function augroup(name)
	return vim.api.nvim_create_augroup("therealyo" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- show Blank Line only in active window
local blanklineGrp = vim.api.nvim_create_augroup("BlankLine", { clear = true })
vim.api.nvim_create_autocmd(
	{ "InsertLeave", "WinEnter" },
	{ pattern = "*", command = ":IBLEnable", group = blanklineGrp }
)
vim.api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = ":IBLDisable", group = blanklineGrp }
)

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("DiffviewClose")
	end,
})
