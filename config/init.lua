local wezterm = require("wezterm")

local Config = {}
Config.__index = Config

function Config:init()
	local config = setmetatable({ options = {} }, self)
	return config
end

function Config:append(new_options)
	for k, v in pairs(new_options) do
		if self.options[k] ~= nil then
			wezterm.log_warn("该配置项已设置")
			goto continue
		end
		self.options[k] = v
		::continue::
	end
	return self
end

-- event
wezterm.on("window-config-reloaded", function(window, pane)
	local id = tostring(window:window_id())
	local seen = wezterm.GLOBAL.seen_windows or {}
	local is_new_window = not seen[id]
	seen[id] = true
	wezterm.GLOBAL.seen_windows = seen
	if is_new_window then
		window:set_position(250, 180)
	end
end)


return Config
