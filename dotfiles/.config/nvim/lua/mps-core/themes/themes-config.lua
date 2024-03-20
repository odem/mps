-- Set the colorscheme to tokyonight using a protected call
-- in case it isn't installed

local M = {}

function M.setColorScheme(name)
	local status, _ = pcall(vim.cmd, "colorscheme " .. name)
	if not status then
		print("Colorscheme not found!")
		return
	end
end
M.setColorScheme("tokyonight")
return M

