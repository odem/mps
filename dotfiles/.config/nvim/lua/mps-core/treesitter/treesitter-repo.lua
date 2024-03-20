return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"tree-sitter/tree-sitter-regex",
	},
	build = ":TSUpdate",
}
