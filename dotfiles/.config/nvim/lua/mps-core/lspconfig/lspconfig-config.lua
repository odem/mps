local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
end

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Setup language servers.
	lspconfig.pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				disableLanguageServices = false,
				disableTaggedHints = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autosearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
				venvPath = vim.fn.getcwd() .. "/.venv",
				pathonPath = vim.fn.getcwd() .. "/.venv/bin/python",
			},
		},
	})
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"javascript",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME .. "/lua",
						vim.fn.expand("config") .. "/lua",
					},
				},
			},
		},
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local pylint = require("efmls-configs.linters.pylint")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	lspconfig.efm.setup({
		filetype = { "lua", "python", "typescript", "javascript", "sh" },
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				sh = { shellcheck, shfmt },
				lua = { luacheck, stylua },
				python = { pylint, black },
				typescript = { eslint_d, prettierd },
				javascript = { eslint_d, prettierd },
			},
		},
	})

	lspconfig.bashls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"sh",
			"bash",
		},
		single_file_support = true,
		settings = {
			bashIde = {
				shellcheckPath = "shellcheck",
				shellcheckArguments = "-a -C -S info -W 1 -x",
				logLevel = "info",
				includeAllWorkspaceSymbols = true,
				enableSourceErrorDiagnostics = true,
				backgroundAnalysisMaxFiles = 500,
				globPattern = "*@(.sh|.bash|.inc|.bash|.command)",
				explainshellEndpoint = "",
			},
		},
	})
	lspconfig.rust_analyzer.setup({
		settings = {
			["rust-analyzer"] = {},
		},
	})
end
config()
