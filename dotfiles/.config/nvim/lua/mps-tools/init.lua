local M = {}
M.getplugins = function()
	return {
		require("mps-tools.debug.debug-repo"),
		require("mps-tools.nvim-surround.nvim-surround-repo"),
		require("mps-tools.project.project-repo"),
		require("mps-tools.overseer.overseer-repo"),
		require("mps-tools.lazygit.lazygit-repo"),
		require("mps-tools.dadbod.dadbod-repo"),
		require("mps-tools.dressing.dressing-repo"),
		require("mps-tools.noice.noice-repo"),
		require("mps-tools.swenv.swenv-repo"),
		require("mps-tools.toggleterm.toggleterm-repo"),
		require("mps-tools.todo-comments.todo-comments-repo"),
		require("mps-tools.neogen.neogen-repo"),
		require("mps-tools.yanky.yanky-repo"),
		require("mps-tools.minipairs.minipairs-repo"),
		require("mps-tools.nvim-hlslens.nvim-hlslens-repo"),
		require("mps-tools.nvim-ts-autotag.nvim-ts-autotag-repo"),
		require("mps-tools.vim-rest-console.vim-rest-console-repo"),
		require("mps-tools.other.other-repo"),
		--require("mps-tools.gp.gp-repo"),
	}
end
M.configure = function()
	-- Configure
	require("mps-tools.debug.debug-config")
	require("mps-tools.overseer.overseer-config")
	require("mps-tools.project.project-config")
	require("mps-tools.dressing.dressing-config")
	require("mps-tools.noice.noice-config")
	require("mps-tools.swenv.swenv-config")
	require("mps-tools.toggleterm.toggleterm-config")
	require("mps-tools.nvim-ts-autotag.nvim-ts-autotag-config")
	require("mps-tools.neogen.neogen-config")
	require("mps-tools.yanky.yanky-config")
	require("mps-tools.minipairs.minipairs-config")
	require("mps-tools.nvim-hlslens.nvim-hlslens-config")
	require("mps-tools.vim-rest-console.vim-rest-console-config")
	--require("mps-tools.gp.gp-config")

	-- Keymaps
	require("mps-tools.keymaps")
	require("mps-tools.nvim-hlslens.nvim-hlslens-keymaps")
	require("mps-tools.debug.debug-keymaps")
	require("mps-tools.dadbod.dadbod-keymaps")
	--require("mps-tools.gp.gp-keymaps")
end
return M
