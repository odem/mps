local M = {}
M.getplugins = function()
	return {
		require("mps-core.mason.mason-repo"),
		require("mps-core.treesitter.treesitter-repo"),
		require("mps-core.neoconf.neoconf-repo"),
		require("mps-core.lspconfig.lspconfig-repo"),
		require("mps-core.lspsaga.lspsaga-repo"),
		require("mps-core.telescope.telescope-repo"),
		require("mps-core.nerdtree.nerdtree-repo"),
		--require("mps-core.nvim-tree.nvim-tree-repo"),
		require("mps-core.undotree.undotree-repo"),
		require("mps-core.harpoon.harpoon-repo"),
		require("mps-core.whichkey.whichkey-repo"),
		require("mps-core.nvimcmp.nvimcmp-repo"),
		require("mps-core.luasnip.luasnip-repo"),
		require("mps-core.comment.comment-repo"),
		require("mps-core.themes.themes-repo"),
		require("mps-core.snipe.snipe-repo"),
	}
end
M.configure = function()
	-- Configure
	require("mps-core.treesitter.treesitter-config")
	require("mps-core.neoconf.neoconf-config")
	require("mps-core.lspconfig.lspconfig-config")
	require("mps-core.lspsaga.lspsaga-config")
	require("mps-core.telescope.telescope-config")
	--require("mps-core.nvim-tree.nvim-tree-config")
	require("mps-core.nvimcmp.nvimcmp-config")
	require("mps-core.luasnip.luasnip-config")
	require("mps-core.comment.comment-config")
	require("mps-core.themes.themes-config")
	require("mps-core.snipe.snipe-config")

	-- Keymaps
	require("mps-core.keymaps")
	require("mps-core.telescope.telescope-keymaps")
	require("mps-core.nerdtree.nerdtree-keymaps")
	-- require("mps-core.nvim-tree.nvim-tree-keymaps")
	require("mps-core.harpoon.harpoon-keymaps")
	require("mps-core.nvimcmp.nvimcmp-keymaps")

	-- Autocmd
	require("mps-core.lspconfig.lspconfig-autocmd")

	-- Set global variables
	require("mps-core.vars")
end
return M
