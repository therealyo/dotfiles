-- Used by the dashboard footer to report startup time.
_G.NVIM_STARTED_AT = vim.uv.hrtime()

-- keymaps
require("config.keymaps")

-- Autocommands
require("config.autocommands")

-- Options
require("config.options")

-- Plugins
require("config.pack")

-- Colorscheme
require("config.colorscheme")

vim.lsp.log.set_level("debug")
