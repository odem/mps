local opts = {
	ensure_installed = {
		"efm",
		"stylua",
		"lua-language-server",
		"luacheck",
		"typescript-language-server",
		"prettierd",
		"eslint_d",
		"css-lsp",
		"prettierd",
		"ltex-ls",
		"markdownlint",
		"shfmt",
		"black",
		"mypy",
		"pyright",
		"julia-lsp",
		"debugpy",
		"bash-debug-adapter",
		"bash-language-server",
		"shellcheck",
		"gitlint",
		"jsonlint",
		"phpactor",
		"curlylint",
		"djlint",
		"nginx-language-server",
		"docker-compose-language-service",
		"dockerfile-language-server",
		"vim-language-server",
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
