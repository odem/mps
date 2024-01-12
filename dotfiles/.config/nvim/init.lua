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
	require("plugins.themes"),
	require("plugins.other"),
	-- major
	require("plugins.telescope"),
	require("plugins.nvimcmp"),
	require("plugins.lspconfig"),
	require("plugins.none-ls"),
	require("plugins.treesitter"),
	-- minor
	require("plugins.blankindent"),
	require("plugins.bufferline"),
	require("plugins.barbecue"),
	require("plugins.comment"),
	require("plugins.gitsigns"),
	require("plugins.lazygit"),
	require("plugins.autoformat"),
	require("plugins.dadbod"),
	require("plugins.debug"),
}, {})

---- Major
require("config.lsp")
require("config.telescope")
require("config.treesitter")

-- Minor
require("config.blankindent")
require("config.bufferline")
require("config.barbecue")
require("config.comment")
require("config.neovim")
require("config.cmp")
require("config.luasnip")
require("config.lualine")
require("config.noice")
require("config.alpha")
require("config.webicons")
require("config.colors")
require("config.colorizer")
require("config.dressing")
require("config.nvim-tree")
require("config.yank")
require("config.toggleterm")
require("config.swenv")

-- Main
require("main.autocmd")
require("main.keymap")
require("main.set")
