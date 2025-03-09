local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
	-- client.server_capabilities.completionProvider = true
	-- client.server_capabilities.documentFormattingProvider = true
	-- client.server_capabilities.documentRangeFormattingProvider = true
	-- client.server_capabilities.hoverProvider = true
	-- client.server_capabilities.signatureHelpProvider = true
	print("Lsp '", client.name, "' attached to buffer ", bufnr)
end
local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"

local config = function()
	-- ############################################################################
	-- # Setup
	-- ############################################################################
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
	local capabilities = cmp_nvim_lsp.default_capabilities()
	local vscode_capabilities = vim.lsp.protocol.make_client_capabilities()
	vscode_capabilities.textDocument.completion.completionItem.snippetSupport = true
	-- ############################################################################
	-- # Linters and formatters
	-- ############################################################################
	lspconfig.html.setup({
		on_attach = on_attach,
		capabilities = vscode_capabilities,
		filetypes = { "html", "templ" },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			provideFormatter = true,
		},
		settings = {},
		single_file_support = true,
	})
	lspconfig.cssls.setup({
		on_attach = on_attach,
		capabilities = vscode_capabilities,
		filetypes = { "css", "scss", "less" },
		provideFormatter = true,
		settings = {
			css = {
				validate = true,
			},
			less = {
				validate = true,
			},
			scss = {
				validate = true,
			},
		},
		root_dir = lspconfig.util.root_pattern("package.json", ".git"),
		single_file_support = true,
	})
	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"javascript",
		},
		settings = {},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})
	lspconfig.dockerls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"dockerfile",
		},
		settings = {},
		root_dir = lspconfig.util.root_pattern("Dockerfile"),
		single_file_support = true,
	})
	lspconfig.docker_compose_language_service.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"yaml.docker-compose",
		},
		settings = {},
		root_dir = lspconfig.util.root_pattern(
			"docker-compose.yaml",
			"docker-compose.yml",
			"compose.yaml",
			"compose.yml"
		),
		single_file_support = true,
	})
	lspconfig.texlab.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"tex",
			"plaintex",
			"bib",
		},
		settings = {
			texlab = {
				auxDirectory = ".",
				bibtexFormatter = "texlab",
				build = {
					args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
					executable = "latexmk",
					forwardSearchAfter = false,
					onSave = false,
				},
				chktex = {
					onEdit = false,
					onOpenAndSave = false,
				},
				diagnosticsDelay = 300,
				formatterLineLength = 80,
				forwardSearch = {
					args = {},
				},
				latexFormatter = "latexindent",
				latexindent = {
					modifyLineBreaks = false,
				},
			},
		},
		single_file_support = true,
	})
	lspconfig.jsonls.setup({
		on_attach = on_attach,
		capabilities = vscode_capabilities,
		filetypes = {
			"json",
			"jsonc",
		},
		init_options = {
			provideFormatter = true,
		},
		settings = {},
		root_dir = lspconfig.util.find_git_ancestor(),
		single_file_support = true,
	})
	lspconfig.marksman.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"markdown",
			"markdown.mdx",
		},
		settings = {},
		root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
		single_file_support = true,
	})
	lspconfig.lemminx.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"xml",
			"xsd",
			"xsl",
			"xslt",
			"svg",
		},
		settings = {},
		root_dir = lspconfig.util.find_git_ancestor(),
		single_file_support = true,
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
				shellcheckArguments = "--color=always -S style -W 1 -x",
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
	lspconfig.ruff.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
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
				pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
			},
			python = vim.fn.getcwd() .. "/.venv/bin/python",
		},
	})
	lspconfig.taplo.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"toml",
			"lsp",
			"stdio",
		},
		settings = {},
		root_dir = lspconfig.util.root_pattern(".toml", ".git"),
		single_file_support = true,
	})
	lspconfig.vimls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"vim",
		},
		settings = {},
		init_options = {
			diagnostic = {
				enable = true,
			},
			indexes = {
				count = 3,
				gap = 100,
				projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
				runtimepath = true,
			},
			isNeovim = true,
			iskeyword = "@,48-57,_,192-255,-#",
			runtimepath = "",
			suggest = {
				fromRuntimepath = true,
				fromVimruntime = true,
			},
			vimruntime = "",
		},
		single_file_support = true,
	})
	lspconfig.nginx_language_server.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"nginx",
		},
		settings = {},
		single_file_support = true,
	})
	lspconfig.cmake.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"cmake",
		},
		settings = {},
		init_options = {
			buildDirectory = "build",
		},
		root_dir = lspconfig.util.root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake"),
		single_file_support = true,
	})
	lspconfig.clangd.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"c",
			"cpp",
			"objc",
			"objcpp",
			"cuda",
			"proto",
		},
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
		settings = {},
		init_options = {
			buildDirectory = "build",
		},
		root_dir = lspconfig.util.root_pattern(
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git"
		),
		single_file_support = true,
	})
	lspconfig.csharp_ls.setup({
		on_attach = on_attach,
		capabilities = vscode_capabilities,
		filetypes = {
			"cs",
		},
		settings = {},
		init_options = {
			AutomaticWorkspaceInit = true,
		},
		single_file_support = true,
	})
	lspconfig.omnisharp.setup({
		on_attach = on_attach,
		capabilities = vscode_capabilities,
		cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
		filetypes = {
			"cs",
		},
		settings = {},
		init_options = {
			AutomaticWorkspaceInit = true,
		},
		single_file_support = true,
		root_dir = lspconfig.util.root_pattern(".csproject"),
		-- Additional configuration can be added here
	})
	-- ############################################################################
	-- # Linters
	-- ############################################################################
	local luacheck = require("efmls-configs.linters.luacheck")
	local ruff = require("efmls-configs.linters.ruff")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local stylint = require("efmls-configs.linters.stylelint")
	local hadolint = require("efmls-configs.linters.hadolint")
	local markdownlint = require("efmls-configs.linters.markdownlint")
	local jqlint = require("efmls-configs.linters.jq")
	local chktex = require("efmls-configs.linters.chktex")
	local yamllint = require("efmls-configs.linters.yamllint")
	local vint = require("efmls-configs.linters.vint")
	local cmakelint = require("efmls-configs.linters.cmake_lint")
	local clangtidy = require("efmls-configs.linters.clang_tidy")
	local mcs = require("efmls-configs.linters.mcs")

	local xmllint = {
		lintCommand = "xmllint --noout --relaxng --schema /path/to/your/schema.rng -",
		lintStdin = true,
		lintFormats = { "%f:%l: %m" },
	}
	-- ############################################################################
	-- # Formatters
	-- ############################################################################
	local stylua = require("efmls-configs.formatters.stylua")
	local black = require("efmls-configs.formatters.black")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local shellharden = require("efmls-configs.formatters.shellharden")
	local mdformat = require("efmls-configs.formatters.mdformat")
	local jqformat = require("efmls-configs.formatters.jq")
	local latexindent = require("efmls-configs.formatters.latexindent")
	local taplo = require("efmls-configs.formatters.taplo")
	local gersemi = require("efmls-configs.formatters.gersemi")
	local clangformat = require("efmls-configs.formatters.clang_format")
	local xmlformatter = { formatCommand = "xmlformat -", formatStdin = true }
	-- local dotnetformatter = { formatCommand = "dotnet format $(ROOT)", formatStdin = false }
	-- ############################################################################
	-- # Setup
	-- ############################################################################
	lspconfig.efm.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetype = {
			"lua",
			"python",
			"typescript",
			"javascript",
			"sh",
			"html",
			"templ",
			"css",
			"scss",
			"less",
			"templ",
			"dockerfile",
			"markdown",
			"markdown.mdx",
			"json",
			"jsonc",
			"tex",
			"plaintex",
			"bib",
			"xml",
			"xsd",
			"xsl",
			"xslt",
			"svg",
			"yaml",
			"yml",
			"toml",
			"lsp",
			"stdio",
			"vim",
			"cmake",
			"c",
			"c++",
			"objc",
			"objc++",
			"cuda",
			"proto",
			"cs",
		},
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
				sh = { shellcheck },
				lua = { luacheck, stylua },
				python = { ruff, black },
				typescript = { eslint_d, prettierd },
				javascript = { eslint_d, prettierd },
				html = { stylint, prettierd },
				templ = { stylint, prettierd },
				css = { stylint, prettierd },
				scss = { stylint, prettierd },
				less = { stylint, prettierd },
				dockerfile = { hadolint },
				markdown = { markdownlint, mdformat },
				json = { jqlint, jqformat },
				jsonc = { jqlint, jqformat },
				tex = { chktex, latexindent },
				plaintex = { chktex, latexindent },
				bib = { latexindent, chktex },
				xml = { xmllint, xmlformatter },
				xsd = { xmllint, xmlformatter },
				xsl = { xmllint, xmlformatter },
				xslt = { xmllint, xmlformatter },
				svg = { xmllint, xmlformatter },
				yaml = { yamllint, prettierd },
				yml = { yamllint, prettierd },
				toml = { eslint_d, taplo },
				lsp = { eslint_d, taplo },
				stdio = { eslint_d, taplo },
				vim = { vint },
				cmake = { cmakelint, gersemi },
				c = { clangtidy, clangformat },
				cpp = { clangtidy, clangformat },
				objc = { clangtidy, clangformat },
				objcpp = { clangtidy, clangformat },
				cs = { mcs },
			},
		},
	})
end
config()
