return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		'williamboman/mason.nvim',
	},
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				nls.builtins.diagnostics.ruff,
				nls.builtins.diagnostics.mypy,
				nls.builtins.diagnostics.pylint,
				nls.builtins.diagnostics.flake8,
				nls.builtins.diagnostics.shellcheck,
				nls.builtins.formatting.black.with({
					extra_args = { "--line-length=79", "--skip-string-normalization" },
					filetypes = {
						"python"
					},
				}),
				nls.builtins.formatting.prettier.with({
					extra_args = {
						"--print-with", "79"
					},
					filetypes = {
						"typescript", "typescriptreact", "javascript", "vue", "json", "yaml"
					},
				}),
			},
		}
	end,
}
