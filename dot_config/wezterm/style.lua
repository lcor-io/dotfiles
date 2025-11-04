local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.color_scheme = "Catppuccin Macchiato"
	config.font = wezterm.font("FiraCode Nerd Font")

	-- Style the window
	config.window_background_opacity = 0.9
	config.window_decorations = "NONE"
	config.enable_scroll_bar = false
	config.inactive_pane_hsb = {}
	config.window_padding = {
		left = 2,
		right = 0,
		top = 2,
		bottom = 0,
	}

	-- Style the tab bar
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.show_tab_index_in_tab_bar = false
	config.show_close_tab_button_in_tabs = false
	config.hide_tab_bar_if_only_one_tab = true
	config.window_frame = {
		font = wezterm.font({ family = "FiraCode Nerd Font" }),
		active_titlebar_bg = "#24273a",
		inactive_titlebar_bg = "#24273a",
	}
	config.colors = {
		tab_bar = {
			background = "#24273a",
			active_tab = {
				bg_color = "#b7bdf8",
				fg_color = "#24273a",
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = "#24273a",
				fg_color = "#cad3f5",
			},
			new_tab = {
				bg_color = "#24273a",
				fg_color = "#cad3f5",
			},
		},
	}

end

return module
