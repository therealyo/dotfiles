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
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "GitHub Dark" -- Set the theme to GitHub Dark
-- config.window_background_opacity = 0.9 -- Slight transparency for the terminal background
config.colors = {
	tab_bar = {
		background = "#282c34",
		active_tab = {
			bg_color = "#61afef",
			fg_color = "#282c34",
		},
		inactive_tab = {
			bg_color = "#3e4451",
			fg_color = "#abb2bf",
		},
	},
}

config.window_padding = {
	left = 20,
	right = 5,
	top = 10,
	bottom = 0,
}

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
-- Font settings (matching VSCode config)
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Consolas",
	"Courier New",
	"monospace",
})
config.font_size = 15
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" } -- Enable font ligatures

-- Leader key configuration
config.leader = { key = "a", mods = "CMD", timeout_milliseconds = 2000 }

-- Key bindings
config.keys = {
	-- Split pane horizontally (Leader + d)
	{
		mods = "LEADER",
		key = "d",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split pane vertically (Leader + D)
	{
		mods = "LEADER|SHIFT",
		key = "D",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Close pane (Leader + q)
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Create new tab (Leader + c)
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Move between tabs (Leader + b/n)
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- Navigate between panes using Vim-like motions (Ctrl + h/j/k/l)
	{
		mods = "CMD",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "CMD",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "CMD",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "CMD",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Adjust pane size (Leader + Arrow keys)
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
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

-- Activate tab by number (Leader + number)
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

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

-- Fix highlight on Shift + Arrow keys
-- Removed conflicting key bindings to allow default behavior

-- TMUX-like status bar
wezterm.on("update-right-status", function(window, _)
	local solid_left_arrow = ""
	local arrow_foreground = { foreground = { color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- Ocean wave
		solid_left_arrow = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		arrow_foreground = { foreground = { color = "#1e2030" } }
	end -- Arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ background = { color = "#b7bdf8" } },
		{ text = prefix },
		arrow_foreground,
		{ text = solid_left_arrow },
	}))
end)

-- Return the configuration to WezTerm
return config
