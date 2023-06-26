local M = {}

---@class ColorSchemeRandomizerSettings
---@field plugins table | nil supply list of plugin names. `plugin_strategy` is used to detect the directory these plugins exist. `nil` means use all colorscheme plugins.
---@field plugin_strategy string | nil strategy can be `lazy` or `nil`
---@field colorschemes table | nil supply list of colorschemes. when defined, only these colorschemes can be picked from.
---@field exclude_colorschemes table | nil supply list of colorschemes to never pick from. when defined, these colorschemes can never be picked from.
---@field apply_scheme boolean applies colorscheme via `vim.cmd.colorscheme`. By default, the colorscheme is applied
local DEFAULT_SETTINGS = {
	plugins = nil,
	colorschemes = nil,
	exclude_colorschemes = nil,
	plugin_strategy = nil,
	apply_scheme = true,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts ColorSchemeRandomizerSettings
function M.set(opts)
	M.current = vim.tbl_deep_extend('force', M.current, opts)

	vim.validate({
		apply_scheme = { M.current.apply_scheme, 'boolean', false },
		plugin_strategy = { M.current.plugin_strategy, 'string', true },
		plugins = { M.current.plugins, 'table', true },
		colorschemes = { M.current.colorschemes, 'table', true },
		exclude_colorschemes = { M.current.exclude_colorschemes, 'table', true },
	})
end

return M
