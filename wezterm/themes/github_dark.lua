-- themes/github_ultradark.lua

-- Define the Color utility module
local Color = {}
Color.__index = Color

local function clamp(value, min, max)
	if value < min then
		return min
	elseif value > max then
		return max
	end
	return value
end

function Color.new(r, g, b, a)
	local self = setmetatable({}, Color)
	self.red = clamp(r, 0, 255)
	self.green = clamp(g, 0, 255)
	self.blue = clamp(b, 0, 255)
	self.alpha = a and clamp(a, 0, 1) or 1
	return self
end

function Color:to_css()
	return string.format(
		"#%02x%02x%02x",
		math.floor(self.red + 0.5),
		math.floor(self.green + 0.5),
		math.floor(self.blue + 0.5)
	)
end

function Color:blend(other, alpha)
	local r = (other.red - self.red) * alpha + self.red
	local g = (other.green - self.green) * alpha + self.green
	local b = (other.blue - self.blue) * alpha + self.blue
	return Color.new(r, g, b)
end

-- Define the color palette
local palette = {
	black = Color.new(13, 17, 23),
	red = Color.new(255, 123, 114),
	green = Color.new(63, 185, 80),
	yellow = Color.new(210, 153, 34),
	blue = Color.new(88, 166, 255),
	magenta = Color.new(188, 140, 255),
	cyan = Color.new(57, 197, 207),
	white = Color.new(177, 186, 196),
	bright_black = Color.new(72, 79, 88),
	bright_red = Color.new(255, 161, 152),
	bright_green = Color.new(86, 211, 100),
	bright_yellow = Color.new(227, 179, 65),
	bright_blue = Color.new(121, 192, 255),
	bright_magenta = Color.new(210, 168, 255),
	bright_cyan = Color.new(86, 212, 221),
	bright_white = Color.new(240, 246, 252),
	background = Color.new(48, 54, 61),
	foreground = Color.new(230, 237, 243),
}

-- Generate the color scheme
local colors = {
	foreground = palette.foreground:to_css(),
	background = palette.background:to_css(),
	cursor_bg = palette.foreground:to_css(),
	cursor_fg = palette.background:to_css(),
	selection_bg = palette.blue:blend(palette.foreground, 0.3):to_css(),
	selection_fg = palette.foreground:to_css(),
	ansi = {
		palette.black:to_css(),
		palette.red:to_css(),
		palette.green:to_css(),
		palette.yellow:to_css(),
		palette.blue:to_css(),
		palette.magenta:to_css(),
		palette.cyan:to_css(),
		palette.white:to_css(),
	},
	brights = {
		palette.bright_black:to_css(),
		palette.bright_red:to_css(),
		palette.bright_green:to_css(),
		palette.bright_yellow:to_css(),
		palette.bright_blue:to_css(),
		palette.bright_magenta:to_css(),
		palette.bright_cyan:to_css(),
		palette.bright_white:to_css(),
	},
}

-- Return the colors table
return {
	colors = colors,
}
