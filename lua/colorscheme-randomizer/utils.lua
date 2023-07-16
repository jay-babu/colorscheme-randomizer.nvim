local M = {}

M.create_path = function(path)
	path = path or vim.fn.stdpath('data') .. '/colorschemes'
	vim.fn.mkdir(path, 'p')
end

M.get_path_sep = function()
	if jit then
		if jit.os == 'Windows' then
			return '\\'
		else
			return '/'
		end
	else
		return package.config:sub(1, 1)
	end
end

M.get_bps_path = function()
	local path_sep = M.get_path_sep()
	local base_filename = vim.fn.getcwd()

	if jit and jit.os == 'Windows' then
		base_filename = base_filename:gsub(':', '_')
	end

	local cp_filename = base_filename:gsub(path_sep, '_') .. '.json'
	return vim.fn.stdpath('data') .. '/colorschemes' .. path_sep .. cp_filename
end

M.load_bps = function(path)
	path = path or vim.fn.stdpath('data') .. '/colorschemes'
	local fp = io.open(path, 'r')

	local bps = nil
	if fp ~= nil then
		local load_bps_raw = fp:read('*a')
		bps = vim.fn.json_decode(load_bps_raw)
		fp:close()
	end

	return bps
end

M.write_bps = function(path, bps)
	bps = bps or {}
	assert(
		type(bps) == 'table',
		"The data should be stored in a table. Usually it is not the user's problem if you did not call the write_bps function explicitly."
	)

	local fp = io.open(path, 'w+')
	if fp == nil then
		vim.notify('Failed to save checkpoints. File: ' .. vim.fn.expand('%'), 'WARN')
		return false
	else
		fp:write(vim.fn.json_encode(bps))
		fp:close()

		return true
	end
end

return M
