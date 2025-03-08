-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Create the configuration
local config = wezterm.config_builder()
local mux = wezterm.mux

-- constants
local BASE_WINDOW_RATIO = 0.5

-- params
local toggleOnOut = false
local windowRatio = BASE_WINDOW_RATIO

-- Utils
local setWindowSize = function(window, ratio)
	local screen = wezterm.gui.screens().active
	window:set_position(0, 0)
	window:set_inner_size(screen.width * ratio, screen.height)
end

local getDefaultWindowSettings = function()
	local screen = wezterm.gui.screens().active
	local position = { 0, 0 }
	local size = { screen.width * BASE_WINDOW_RATIO, screen.height }
	return screen, position, size
end

local increaseWindowSize = function(window)
	windowRatio = windowRatio + 0.02
	setWindowSize(window, windowRatio)
end

local decreaseWindowSize = function(window)
	windowRatio = windowRatio - 0.02
	setWindowSize(window, windowRatio)
end

local toggleMaximize = function(window)
	local screen, position, size = getDefaultWindowSettings()

	if window:get_dimensions().pixel_width <= size[1] then
		-- maximize
		window:set_position(table.unpack(position))
		window:set_inner_size(math.max(screen.width * 0.8, screen.width * windowRatio), screen.height)
	else
		-- restore default
		window:set_position(table.unpack(position))
		window:set_inner_size(table.unpack(size))
	end
end

local resetWindow = function(window)
	windowRatio = 0.5
	setWindowSize(window, windowRatio)
end

--Helper function to extend the config
local function extend(tbl, newProps)
	for k, v in pairs(newProps) do
		tbl[k] = v
	end
end

-- Events
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	resetWindow(window:gui_window())
end)

wezterm.on("window-focus-changed", function(window)
	if not toggleOnOut then
		return
	end

	local screen, position, _ = getDefaultWindowSettings()

	if window:is_focused() then
		-- maximize
		window:set_position(table.unpack(position))
		window:set_inner_size(screen.width * 0.6, screen.height)
	else
		-- restore default
		window:set_position(table.unpack(position))
		window:set_inner_size(screen.width * 0.3, screen.height)
	end
end)

-- Base settings
extend(config, {
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("Fira Code"),
	font_size = 12.5,
	window_decorations = "NONE",
	hide_tab_bar_if_only_one_tab = true,

	-- WSL Domains
	wsl_domains = {
		{
			name = "wsl:arch",
			distribution = "Arch",
			default_cwd = "~",
		},
	},
	default_domain = "wsl:arch",
	-- Keybindings
	keys = {
		{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
		{ key = "r", mods = "CTRL|SHIFT", action = wezterm.action_callback(resetWindow) },
		{ key = "m", mods = "CTRL|SHIFT", action = wezterm.action_callback(toggleMaximize) },
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(function()
				toggleOnOut = not toggleOnOut
			end),
		},

		{ key = ">", mods = "CTRL|SHIFT", action = wezterm.action_callback(increaseWindowSize) },
		{ key = "<", mods = "CTRL|SHIFT", action = wezterm.action_callback(decreaseWindowSize) },
	},
})

-- Return final configuration
return config
