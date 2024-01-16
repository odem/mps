return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		'williamboman/mason.nvim',
		'nvim-lua/plenary.nvim' ,
	},
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				nls.builtins.diagnostics.gitlint,
				nls.builtins.diagnostics.jsonlint,
				nls.builtins.diagnostics.luacheck,
				nls.builtins.diagnostics.markdownlint,
				nls.builtins.diagnostics.cppcheck,
				nls.builtins.diagnostics.cpplint,
				nls.builtins.diagnostics.curlylint,
				nls.builtins.diagnostics.djlint,
				nls.builtins.code_actions.eslint_d,
				nls.builtins.completion.luasnip,
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
				nls.builtins.code_actions.gitsigns.with({
				config = {
					filter_actions = function(title)
						return title:lower():match("blame") == nil -- filter out blame actions
					end,
				},
			})
			},
		}
	end,
}
