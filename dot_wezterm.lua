-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.default_prog = { "/usr/bin/nu" }
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("FiraCode Nerd Font")

-- Style the window
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
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

-- Key bindings
local act = wezterm.action
config.keys = {

	-- Navigate tabs
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

	-- Navigate panes
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },

	-- Open new Pane and Window
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 30 },
		}),
	},
	{
		key = "t",
		mods = "SUPER",
		action = act.SpawnWindow,
	},

	-- Rename the current tab
	{
		key = "t",
		mods = "CTRL|SHIFT|ALT",
		action = act.PromptInputLine({
			description = "Enter new tab name",
			initial_value = "",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- Add spacer between tabs 
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#24273a'
    local background = '#24273a'
    local foreground = '#c0c0c0'

    if tab.is_active then
      background = "#24273a"
      foreground = "#cad3f5"
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

return config
