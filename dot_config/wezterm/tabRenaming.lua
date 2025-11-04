local wezterm = require("wezterm")

local module = {}

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

function module.apply_to_config(config)
	wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
		local edge_background = "#24273a"
		local background = "#24273a"
		local foreground = "#cad3f5"

		if tab.is_active then
			background = "#24273a"
			foreground = "#b7bdf8"
		elseif hover then
			background = "#24273a"
			foreground = "#b7bdf8"
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
	end)
end

return module
