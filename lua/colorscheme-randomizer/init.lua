local M = {}

M.result = {}

--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Check if a directory exists in this path
local function isdir(path)
	-- "/" works on both Unix and Windows
	return exists(path .. '/')
end

local function retrieve_colors(plugins)
	local colors = {}
	for _, plugin in ipairs(plugins) do
		local dir = plugin.dir .. '/colors'

		local pfile = io.popen('ls -A ' .. dir)
		for filename in pfile:lines() do
			filename = filename:gsub('%.vim', '')
			filename = filename:gsub('%.lua', '')
			table.insert(colors, filename)
		end
	end
	return colors
end

local function detect_plugin_dirs()
	local current = require('colorscheme-randomizer.settings').current
	local plugins = current.plugins

	if current.plugin_strategy == 'lazy' then
		local _, lazy_config = pcall(require, 'lazy.core.config')
		return vim.tbl_filter(function(plugin)
			if isdir(plugin.dir .. '/colors') and vim.tbl_contains(plugins or { plugin.name }, plugin.name) then
				return true
			end
			return false
		end, lazy_config.plugins)
	end
end

function M.randomize()
	local current = require('colorscheme-randomizer.settings').current
	M.result.curr_colorscheme = M.result.colorschemes[math.random(#M.result.colorschemes)]

	if current.apply_scheme then
		vim.cmd.colorscheme(M.result.curr_colorscheme)
	end
end

---@param config ColorSchemeRandomizerSettings | nil
function M.setup(config)
	-- start rolling the dice
	-- https://stackoverflow.com/questions/18199844/lua-math-random-not-working
	math.randomseed(os.time())
	math.random()
	math.random()
	math.random()

	local settings = require('colorscheme-randomizer.settings')
	if config then
		settings.set(config)
	end
	local current = require('colorscheme-randomizer.settings').current

	local detected_plugins = detect_plugin_dirs()

	M.result.colorschemes = current.colorschemes or retrieve_colors(detected_plugins)

	M.randomize()
end

return M
