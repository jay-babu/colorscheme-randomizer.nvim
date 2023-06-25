local M = {}

---@class ColorSchemeRandomizerSettings
---@field plugins table
---@field apply_scheme boolean applies colorscheme via `vim.cmd.colorscheme`. By default, the colorscheme is applied
local DEFAULT_SETTINGS = {
	plugins = {},
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
		plugins = { M.current.plugins, 'table', false },
	})
end

return M
