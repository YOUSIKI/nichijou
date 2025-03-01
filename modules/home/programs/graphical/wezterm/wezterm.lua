local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- local function scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return "Catppuccin Mocha"
-- 	else
-- 		return "Catppuccin Frappe"
-- 	end
-- end

-- local appearance = wezterm.gui.get_appearance()

-- config.color_scheme = scheme_for_appearance(appearance)

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
	"CaskaydiaCove Nerd Font Mono",
	"CaskaydiaCove Nerd Font",
	"Cascadia Code PL",
	"Cascadia Code",
	"Fira Code",
	"Source Code Pro",
})

config.font_size = 13.0

return config
