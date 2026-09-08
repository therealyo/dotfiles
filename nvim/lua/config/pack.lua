-- Plugins, managed by Neovim's built-in plugin manager. See `:help vim.pack`.
--
-- Every file in `lua/plugins/` returns a table:
--
--   return {
--     "owner/repo",                              -- shorthand, expanded to GitHub
--     { src = "owner/repo", name = "nicer" },    -- full `vim.pack.Spec`
--     config = function() ... end,               -- optional
--   }
--
-- All sources are collected and handed to a single `vim.pack.add()` call, so
-- missing plugins are cloned in parallel. Afterwards every `config` runs, in
-- alphabetical order of the file names. Sources repeated across files are
-- deduplicated, so each file can list the plugins it needs.
--
-- vim.pack has no lazy loading: everything is on the 'runtimepath' from the
-- start, and `plugin/` files are sourced right after `init.lua` (`:packadd!`
-- semantics). Build steps are not part of a spec either -- they live in the
-- `PackChanged` hooks below.

local plugins_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")

-- Build steps, keyed by plugin name. Run on install and on update.
local builds = {
	["LuaSnip"] = function(path)
		-- Needed for regex support in snippets. Not supported in many Windows
		-- environments, so skip it there.
		if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
			return
		end
		vim.system({ "make", "install_jsregexp" }, { cwd = path })
	end,
	["telescope-fzf-native.nvim"] = function(path)
		vim.system({ "make" }, { cwd = path })
	end,
	["nvim-treesitter"] = function()
		-- Parsers are installed by the plugin's own config; this refreshes them.
		vim.schedule(function()
			vim.cmd("TSUpdate")
		end)
	end,
	["molten-nvim"] = function()
		vim.schedule(function()
			vim.cmd("UpdateRemotePlugins")
		end)
	end,
}

vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("therealyo_pack_build", { clear = true }),
	callback = function(event)
		local build = builds[event.data.spec.name]
		if build and (event.data.kind == "install" or event.data.kind == "update") then
			build(event.data.path)
		end
	end,
})

-- "owner/repo" is expanded to a GitHub URL; anything with a scheme is kept.
local function to_spec(src)
	local spec = type(src) == "string" and { src = src } or vim.deepcopy(src)
	if not spec.src:find("://", 1, true) then
		spec.src = "https://github.com/" .. spec.src
	end
	spec.name = spec.name or vim.fs.basename(spec.src):gsub("%.git$", "")
	return spec
end

local modules = {}
for name, kind in vim.fs.dir(plugins_dir) do
	if kind == "file" and name:sub(-4) == ".lua" then
		table.insert(modules, name:sub(1, -5))
	end
end
table.sort(modules)

local specs, configs, seen = {}, {}, {}

-- The same plugin is often listed by several files, usually bare in one and
-- with a `version` in another. Merge them so a bare mention can't drop the
-- options; genuinely conflicting values are reported rather than picked from.
local function merge(spec, module)
	local kept = seen[spec.name]
	if not kept then
		seen[spec.name] = { spec = spec, module = module }
		table.insert(specs, spec)
		return
	end

	for key, value in pairs(spec) do
		if kept.spec[key] == nil then
			kept.spec[key] = value
		elseif not vim.deep_equal(kept.spec[key], value) then
			vim.notify(
				("pack: %s has conflicting %s in plugins.%s and plugins.%s, using the former"):format(
					spec.name,
					key,
					kept.module,
					module
				),
				vim.log.levels.WARN
			)
		end
	end
end

for _, module in ipairs(modules) do
	local plugin = require("plugins." .. module)

	for _, src in ipairs(plugin) do
		merge(to_spec(src), module)
	end

	if plugin.config then
		table.insert(configs, { module = module, config = plugin.config })
	end
end

-- `confirm = false` keeps missing plugins installing unattended, the way
-- lazy.nvim's `install.missing` did.
vim.pack.add(specs, { confirm = false })

for _, entry in ipairs(configs) do
	local ok, err = pcall(entry.config)
	if not ok then
		vim.notify(("plugins.%s: %s"):format(entry.module, err), vim.log.levels.ERROR)
	end
end
