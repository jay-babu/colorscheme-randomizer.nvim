local M = {}

M.result = {}

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
local function is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
	return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

local function retrieve_colors(plugin)
	local colors = {}
	if not is_available(plugin) then
		return colors
	end
	local _, lazy_config = pcall(require, 'lazy.core.config')
	local dir = lazy_config.plugins[plugin].dir .. '/colors'

	local pfile = io.popen('ls -A ' .. dir)
	for filename in pfile:lines() do
		filename = filename:gsub('%.vim', '')
		filename = filename:gsub('%.lua', '')
		table.insert(colors, filename)
	end
	return colors
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
	-- local _, lazy_config = pcall(require, 'lazy.core.config')
	-- local detected_plugin_names = vim.tbl_filter(function(plugin)
	-- 	return plugin.dir
	-- end, lazy_config.plugins)

	if config then
		settings.set(config)
	end
	local current = require('colorscheme-randomizer.settings').current

	local plugins = current.plugins

	-- vim.print(vim.inspect(#plugins))
	local random_plugin = plugins[math.random(#plugins)]
	-- vim.print(vim.inspect(random_plugin))
	local colors = retrieve_colors(random_plugin)
	M.result.theme = colors[math.random(#colors)]
	-- vim.print(vim.inspect(M.result.theme))

	if current.apply_scheme then
		vim.cmd.colorscheme(M.result.theme)
	end
end

return M
