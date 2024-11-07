return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	 -- stylua: ignore
	 keys = {
	   { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[f]lash" },
	   { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[F]lash Treesitter" },
	   { "r", mode = "o", function() require("flash").remote() end, desc = "[R]emote Flash" },
	   { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	   { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	 },
}
