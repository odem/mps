return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			opts = {
				ensure_installed = {
					"stylua",
					"shfmt",
					"flake8",
					"black",
					"ruff",
					"mypy",
					"prettier",
					"bash-debug-adapter",
					"debugpy",
					"luau-lsp",
					"gitlint",
					"jsonlint",
					"luacheck",
					"markdownlint",
					"phpactor",
					"luaformatter",
					"sqls",
					"cpplint",
					"curlylint",
					"djlint",
					"eslint_d",
					"nginx-language-server",
					"ltex-ls",
					"vim-language-server",
				},
			},
			config = function(_, opts)
				require("mason").setup(opts)
				local mr = require("mason-registry")
				local function ensure_installed()
					for _, tool in ipairs(opts.ensure_installed) do
						local p = mr.get_package(tool)
						if not p:is_installed() then
							p:install()
						end
					end
				end
				if mr.refresh then
					mr.refresh(ensure_installed)
				else
					ensure_installed()
				end
			end,
		},
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
		"folke/neodev.nvim",
	},
}
