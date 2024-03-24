-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Keys
		local K = require("mps-core.lspconfig.lspconfig-keymaps")
		K.lspkeys(ev)
	end,
})
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		vim.cmd("Neoformat")
		local efm = vim.lsp.get_active_clients({ name = "efm" })
		if vim.tbl_isempty(efm) then
			return
		end
		vim.lsp.buf.format({ name = "efm" })
	end,
})
