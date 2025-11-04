-- Pull in the wezterm API
local wezterm = require("wezterm")

local keybinds = require("keybinds")
local tab = require("tabRenaming")
local style = require("style")

-- This will hold the configuration
local config = wezterm.config_builder()

config.default_prog = { "/usr/bin/nu" }

style.apply_to_config(config)
keybinds.apply_to_config(config)
tab.apply_to_config(config)

return config
