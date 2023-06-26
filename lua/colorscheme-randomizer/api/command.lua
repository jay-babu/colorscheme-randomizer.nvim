vim.api.nvim_create_user_command('ColorschemeRandomize', function(_)
	require('colorscheme-randomizer').randomize()
end, {
	desc = 'Randomly chooses another colorscheme. Respects `apply_scheme`.',
	nargs = 0,
})
