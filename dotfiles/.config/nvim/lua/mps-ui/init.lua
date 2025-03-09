local M = {}
M.getplugins = function()
	return {
		require("mps-ui.barbecue.barbecue-repo"),
		require("mps-ui.blankindent.blankindent-repo"),
		require("mps-ui.bufferline.bufferline-repo"),
		require("mps-ui.lualine.lualine-repo"),
		require("mps-ui.gitsigns.gitsigns-repo"),
		require("mps-ui.alpha.alpha-repo"),
		require("mps-ui.airline.airline-repo"),
		require("mps-ui.webicons.webicons-repo"),
		require("mps-ui.nvim-scrollbar.nvim-scrollbar-repo"),
		require("mps-ui.symbols-outline.symbols-outline-repo"),
	}
end
M.configure = function()
	-- Configure
	require("mps-ui.barbecue.barbecue-config")
	require("mps-ui.blankindent.blankindent-config")
	require("mps-ui.bufferline.bufferline-config")
	require("mps-ui.lualine.lualine-config")
	require("mps-ui.alpha.alpha-config")
	require("mps-ui.webicons.webicons-config")
	require("mps-ui.nvim-scrollbar.nvim-scrollbar-config")
	require("mps-ui.symbols-outline.symbols-outline-config")
	require("mps-ui.yank.yank-config")

	-- Keymaps
	require("mps-ui.symbols-outline.symbols-outline-keymaps")
end
return M
