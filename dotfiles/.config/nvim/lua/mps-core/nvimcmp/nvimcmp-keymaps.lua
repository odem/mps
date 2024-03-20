local K = require("mps-core.helpers")
-- Enable/Disable/Toggle Autocomplete
vim.g.cmp_autocomplete = 1

function ToggleAutocomplete()
	vim.g.cmp_autocomplete = not vim.g.cmp_autocomplete
	setAutoCmp(vim.g.cmp_autocomplete)
	print("CMP-Autocomplete is now: " .. tostring(vim.g.cmp_autocomplete))
end

-- vim commands enable,disable,toggle
vim.cmd("command! AutoCmpToggle lua ToggleAutocomplete()")
vim.cmd("command AutoCmpOn lua setAutoCmp(true)")
vim.cmd("command AutoCmpOff lua setAutoCmp(false)")
K.map("n", "<leader>tcon", "<Esc>:AutoCmpOn<CR>", { noremap = true, silent = true })
K.map("n", "<leader>tcoff", "<Esc>:AutoCmpOff<CR>", { noremap = true, silent = true })
K.map("n", "<leader>tcmp", "<Esc>:AutoCmpToggle<CR>", { noremap = true, silent = true })
