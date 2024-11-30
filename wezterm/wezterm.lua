-- Pull in the WezTerm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of WezTerm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color scheme
config.color_scheme = "Catppuccin Frappe"
-- config.color_scheme = "Nightfly (Gogh)"
-- config.color_scheme = "GitHub Dark" -- Set the theme to GitHub Dark
-- config.window_background_opacity = 0.95 -- Slight transparency for the terminal background
-- config.macos_window_background_blur = 20
config.window_padding = {
	left = 5,
	right = 0,
	top = 5,
	bottom = 0,
}

-- config.background = {
-- 	{
-- 		source = {
-- 			File = "/Users/therealyo/dotfiles/wezterm/backgrounds/catppuccin.png",
-- 		},
-- 	},
-- }
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
	local process_name = basename(pane:get_foreground_process_name())
	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- config.keys = {}

config.native_macos_fullscreen_mode = false
-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
-- Font settings (matching VSCode config)
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Consolas",
	"Courier New",
	"monospace",
})

config.line_height = 1.3
config.cell_width = 1.0
config.font_size = 12
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" } -- Enable font ligatures

-- Leader key configuration
config.leader = { key = "a", mods = "CMD", timeout_milliseconds = 2000 }

-- Key bindings
config.keys = {
	-- Split pane horizontally (Leader + d)
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split pane vertically (Leader + D)
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- -- Close pane (Leader + q)
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	-- Move by one word (Option + Arrow keys)
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	},
	-- Move to start/end of line (Cmd + Arrow keys)
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.SendString("\x01"), -- Ctrl+A
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.SendString("\x05"), -- Ctrl+E
	},
	-- Delete one word (Option + Backspace)
	{
		key = "Backspace",
		mods = "OPT",
		action = wezterm.action.SendString("\x17"),
	},
	-- Delete whole line (Cmd + Backspace)
	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action.SendString("\x15"),
	},
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- Go to copy mode
table.insert(config.keys, {
	key = "Space",
	mods = "LEADER",
	action = wezterm.action.ActivateCopyMode,
})
-- Mouse bindings for text selection
config.mouse_bindings = {
	-- Allow selecting text with Shift + mouse drag
	{
		event = { Drag = { streak = 1, button = "Left" } },
		mods = "SHIFT",
		action = wezterm.action({ CompleteSelection = "ClipboardAndPrimarySelection" }),
	},
}

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
