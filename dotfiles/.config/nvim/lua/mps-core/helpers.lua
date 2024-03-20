local M = {}

function M.initLazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

function M.map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

function M.tmap(mode, lhs, rhs, desc)
	M.map(mode, lhs, function()
		local builtin = require("telescope.builtin")
		local ivy = require("telescope.themes").get_ivy()
		local telescope_func_to_call = builtin[rhs]
		if telescope_func_to_call then
			telescope_func_to_call(ivy)
		else
			print("Telescope function not found:", rhs)
		end
	end, { desc = desc })
end

function M.tcmap(mode, lhs, rhs, desc)
	M.map(mode, lhs, function()
		local custom = require("mps-core.telescope.telescope-custom")
		local telescope_func_to_call = custom[rhs]
		if telescope_func_to_call then
			telescope_func_to_call()
		else
			print("Telescope function not found:", rhs)
		end
	end, { desc = desc })
end

-- Delete words with Delete and Backspace
vim.cmd([[
	function! DeleteConditionallyRight()
		let l:char_right = getline('.')[col('.') + 1]
		let l:char_current = getline('.')[col('.')]
		let current_col = col(".")
		let line_length = strlen(getline('.'))
		if current_col == line_length
			"echomsg "EOL"
			execute "normal! J"
		else
			if l:char_right =~# '\s' || col('.') == 1
				"echomsg "WS: " . l:char_right
				execute "normal! lx"
			else
				"echomsg "WORD: " . l:char_right
				execute "normal! dW"
			endif
		endif
	endfunction
]])

vim.cmd([[
	function! DeleteConditionallyLeft()
		let l:char_left = getline('.')[col('.') - 2]
		let l:char_current = getline('.')[col('.') - 1]
		let current_line = line(".")
		let current_col = col(".")
		let line_length = strlen(getline('.'))
		"echomsg "COL: " . current_col . " LINE: " . current_line
		if current_col == 1 && current_line > 1
			" echomsg "BOL"
			execute "normal! k$J"
		else
			if l:char_left =~# '\s' || col('.') == 1
				"echomsg "WS: " . l:char_left
				execute "normal! hx"
			else
				"echomsg "WORD: " . l:char_left
				execute "normal! dB"
			endif
		endif
	endfunction
]])

return M
