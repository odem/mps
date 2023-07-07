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
	require("plugins.chatgpt"),
	require("plugins.lspconfig"),
	require("plugins.telescope"),
	require("plugins.gitsigns"),
	require("plugins.treesitter"),
	require("plugins.lazygit"),
	require("plugins.barbecue"),
	require("plugins.nvimcmp"),
	require("plugins.lualine"),
	require("plugins.surround"),
	require("plugins.trouble"),
	require("plugins.null-ls"),
	require("plugins.autoformat"),
	require("plugins.debug"),
}, {})

-- Configs
require("config.alpha")
require("config.bufferline")
require("config.colors")
require("config.chatgpt")
require("config.comment")
require("config.nerdtree")
require("config.yank")
require("config.telescope")
require("config.treesitter")
require("config.neovim")
require("config.lsp")
require("config.toggleterm")
require("config.barbecue")
require("config.lualine")
require("config.trouble")

-- Main
require("main.autocmd")
require("main.keymap")
require("main.set")
