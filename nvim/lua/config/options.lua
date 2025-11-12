-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs & indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neowill display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.g.accent_colour = "yellow" -- the default
-- vim.g.accent_colour = "orange"
-- vim.g.accent_colour = "red"
-- vim.g.accent_colour = "green"
-- vim.g.accent_colour = "blue"
-- vim.g.accent_colour = "magenta"
-- vim.g.accent_colour = "cyan"

-- g:accent_darken makes the background and some text colours darker.
vim.g.accent_darken = 0 -- the default
-- vim.g.accent_darken = 1

-- g:accent_invert_status inverts the colour of the status line text.
-- vim.g.accent_invert_status = 0 -- the default
vim.g.accent_invert_status = 1

-- g:accent_auto_cwd_colour sets the accent colour using a hash of the current directory.
-- vim.g.accent_auto_cwd_colour = 0 -- the default
-- vim.g.accent_auto_cwd_colour = 1

-- g:accent_no_bg stops the background colour being set, which will use the terminal default
vim.g.accent_no_bg = 0 -- the default
-- vim.g.accent_no_bg = 1
