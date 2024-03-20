return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "creativenull/efmls-configs-nvim" },
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
		{ "windwp/nvim-autopairs" },
		{ "folke/neodev.nvim" },
	},
}
