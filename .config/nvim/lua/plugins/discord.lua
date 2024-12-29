local function get_playerctl_status()
	local handle = io.popen("playerctl status")
	if not handle then
		return ""
	end
	return handle:read("*l")
end

local function get_playerctl_metadata_title()
	local handle = io.popen("playerctl metadata title")
	if not handle then
		return ""
	end
	return handle:read("*l")
end

local function get_playerctl_metadata_artist()
	local handle = io.popen("playerctl metadata artist")
	if not handle then
		return ""
	end
	return handle:read("*l")
end

local function get_player_text()
	return get_playerctl_metadata_title() .. " - " .. get_playerctl_metadata_artist()
end

local function workspace_text_option(...)
	if get_playerctl_status() == "" then
		return ...
	end

	return get_player_text() .. " | " .. ...
end

return {
	{
		"IogaMaster/neocord",
		event = "VeryLazy",
		opts = {
			workspace_text = workspace_text_option,
		},
	},
}
