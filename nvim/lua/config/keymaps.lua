vim.g.mapleader = " "
vim.keymap.set("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep screen centered on cursor on moves
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever(don't clear yank buffer on paste)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland (copy to system clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Find and replace
vim.keymap.set("n", "<leader>F", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

-- BufferLine
vim.keymap.set("n", "<S-b>", "<cmd> enew <CR>") --"烙 new buffer"
vim.keymap.set("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>") --"  cycle next buffer"
vim.keymap.set("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>") --"  cycle prev buffer"
vim.keymap.set("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>") --"  cycle next buffer"
vim.keymap.set("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>") --"  cycle prev buffer"
vim.keymap.set("n", "<A-f>", "<cmd> BufferLinePick <CR>")
vim.keymap.set("n", "<leader>B", "<cmd> bp|sp|bn|bd! <CR>")
for i = 1, 9 do
	-- vim.keymap.set("n", "<A-" .. i .. ">", function() require("bufferline").go_to_buffer(i) end)
	vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>" .. i .. "tabn<CR>")
end
