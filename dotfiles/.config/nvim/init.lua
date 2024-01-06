-- Always set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Lazy Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
-- Setup
require("lazy").setup({
	-- simple
	require("plugins.other"),
	-- complex
	require("plugins.blankindent"),
	require("plugins.bufferline"),
	require("plugins.comment"),
	require("plugins.lspconfig"),
	require("plugins.none-ls"),
	require("plugins.telescope"),
	require("plugins.gitsigns"),
	require("plugins.treesitter"),
	require("plugins.lazygit"),
	require("plugins.barbecue"),
	require("plugins.nvimcmp"),
	require("plugins.trouble"),
	require("plugins.autoformat"),
	require("plugins.dadbod"),
	require("plugins.debug"),
}, {})

-- Configs
require("config.alpha")
require("config.blankindent")
require("config.webicons")
require("config.bufferline")
require("config.colors")
require("config.comment")
require("config.nvim-tree")
require("config.yank")
require("config.telescope")
require("config.treesitter")
require("config.neovim")
require("config.lsp")
require("config.cmp")
require("config.luasnip")
require("config.toggleterm")
require("config.barbecue")
require("config.lualine")
require("config.trouble")
require("config.swenv")
require("config.colorizer")

-- Main
require("main.autocmd")
require("main.keymap")
require("main.set")
