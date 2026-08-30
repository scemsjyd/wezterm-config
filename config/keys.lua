local wezterm = require("wezterm")
local platform = require("utils.platform")()
local act = wezterm.action

local mod = {}

if platform.is_mac then
	mod.SUPER = "SUPER"
	mod.SUPER_REV = "SUPER|CTRL"
elseif platform.is_win or platform.is_linux then
	mod.SUPER = "ALT" -- to not conflict with Windows key shortcuts
	mod.SUPER_REV = "ALT|CTRL"
end

local keys = {
	{
		key = "r",
		mods = "SUPER|SHIFT",
		action = act.PromptInputLine({
			description = "输入新的 Tab 名称（留空以恢复默认名称）",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "t",
		mods = "SUPER|SHIFT",
		action = act.ShowTabNavigator,
	},
}

return {
	disable_default_key_bindings = false,
	leader = { key = "Space", mods = mod.SUPER_REV },
	keys = keys,
}
