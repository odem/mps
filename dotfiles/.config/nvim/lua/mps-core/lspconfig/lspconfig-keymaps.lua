local M = {}
local function opt(ev, desc)
	return { buffer = ev.buf, desc = desc }
end

function M.lspkeys(ev)
	local opts = { buffer = ev.buf }
	local K = require("mps-core.helpers")
	-- Default lsp
	K.map("n", "glr", "<cmd>LspRestart<cr>", { desc = "LspRestart" })
	K.map("n", "gli", "<cmd>LspInfo<cr>", { desc = "LspRestart" })
	K.map("n", "gD", vim.lsp.buf.declaration, opt(ev, "LSP [d]eclaration"))
	K.map("n", "gi", vim.lsp.buf.implementation, opt(ev, "LSP [i]mplementation"))
	K.map("n", "gfl", vim.lsp.buf.format, opt(ev, "LSP [f]ormat [l]sp"))
	K.map("n", "gn", vim.lsp.buf.rename, opt(ev, "LSP re[n]ame"))
	K.map("n", "gh", vim.lsp.buf.hover, opt(ev, "LSP [h]over"))
	K.map("n", "gsh", vim.lsp.buf.signature_help, opt(ev, "LSP [s]ignature [h]elp"))
	K.map("n", "gca", vim.lsp.buf.code_action, opt(ev, "LSP [c]ode [a]ction"))
	K.map("n", "gK", vim.lsp.buf.signature_help, opt(ev, "LSP [s]ignature [h]elp"))
	K.map("n", "gk", vim.lsp.buf.hover, opt(ev, "LSP [h]over"))
	K.map("n", "gpoi", "<cmd>PyrightOrganizeImports<CR>", opt(ev, "LSP pyright: [o]rganize [i]mports"))
	K.map("n", "gpsp", function()
		local curdir = vim.fn.PyrightSetPythonPath(vim.fn.getcwd())
		local pypath = curdir .. "*/**"
		vim.api.call_function("PyrightSetPythonPath", { pypath })
	end, opt(ev, "LSP pyright: [s]et [p]ython path"))

	K.map("n", "gsca", "<cmd>Lspsaga code_action<CR>", opt(ev, "LSP [s]aga [d]iagnostics [b]uf "))
	K.map("n", "gsdb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opt(ev, "LSP [s]aga [d]iagnostics [b]uf "))
	K.map("n", "gsdl", "<cmd>Lspsaga show_line_diagnostics<CR>", opt(ev, "LSP [s]aga [d]iagnostics [l]ine "))
	K.map("n", "gsdc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opt(ev, "LSP [s]aga [d]iagnostics [c]ursor"))
	K.map("n", "gsdw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opt(ev, "LSP [s]aga [d]iagnostics [w]orkspace"))

	-- Override through telescope
	-- K.map("n", "gd", vim.lsp.buf.definition, opt(ev, "LSP [d]efinition"))
	-- K.map("n", "gr", vim.lsp.buf.definition, opt(ev, "LSP [r]eferences"))

	-- Diagnostics
	K.map("n", "[d", vim.diagnostic.goto_prev)
	K.map("n", "]d", vim.diagnostic.goto_next)
	K.map("n", "<leader>q", vim.diagnostic.setloclist)
	-- Workspace folders
	K.map("n", "gwfa", vim.lsp.buf.add_workspace_folder, opts)
	K.map("n", "gwfr", vim.lsp.buf.remove_workspace_folder, opts)
	K.map("n", "gwfl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
end

return M
