local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
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
			action = wezterm.action_callback(function(win, pane)
				local panes = win:active_tab():panes()
				if #panes == 1 then
					pane:split({ direction = "Right", size = 0.3 })
				else
					local lastPane = panes[#panes]
					lastPane:split({ direction = "Bottom", size = 0.5 })
				end
			end),
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
end

return module
