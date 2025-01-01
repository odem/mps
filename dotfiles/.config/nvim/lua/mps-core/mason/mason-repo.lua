local opts = {
	ensure_installed = {
		"efm",
		"stylua",
		"lua-language-server",
		"luacheck",
		"typescript-language-server",
		"prettier",
		"prettierd",
		"eslint_d",
		"black",
		"mypy",
		"pyright",
		"ruff",
		"ruff-lsp",
		"debugpy",
		"bash-debug-adapter",
		"bash-language-server",
		"shellcheck",
		"shellharden",
		"html-lsp",
		"css-lsp",
		"stylelint",
		"dockerfile-language-server",
		"docker-compose-language-service",
		"yamllint",
		"hadolint",
		"marksman",
		"markdownlint",
		"mdformat",
		"json-lsp",
		"jq",
		"tree-sitter-cli",
		"texlab",
		"latexindent",
		"lemminx",
		"xmlformatter",
		"taplo",
		"dprint",
		"vim-language-server",
		"vale",
		"nginx-language-server",
		"cmake-language-server",
		"cmakelint",
		"gersemi",
		"clangd",
		"clang-format",
	},
	automatic_installation = true,
}
return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	opts = opts,
	config = function(_, optin)
		require("mason").setup(optin)
		local mr = require("mason-registry")
		local function ensure_installed()
			for _, tool in ipairs(optin.ensure_installed) do
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
}
