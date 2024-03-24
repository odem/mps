local opt = vim.opt
local g = vim.g

-- Cursor highlighting
opt.cursorline = true
opt.cursorcolumn = false

-- Pane splitting
opt.splitright = true
opt.splitbelow = true

-- Searching
opt.smartcase = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.inccommand = "split"

-- Tab config
opt.autoindent = true
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Auto indent

-- Make terminal support truecolor
opt.termguicolors = true
opt.guifont = "JetBrainsMono Nerd Font:h14"
opt.guifontwide = "JetBrains Nerd Font:h14"

-- Make neovim use the system clipboard
opt.clipboard = "unnamedplus"

-- Disable old vim status
opt.showmode = true

-- Set relative line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- Code folding
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"

opt.updatetime = 200
opt.timeout = true
opt.timeoutlen = 300
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.config/nvim-undodir")
opt.backup = false
opt.writebackup = false
--opt.autochdir = true
opt.autochdir = false

opt.filetype = "on"
opt.encoding = "utf-8"
opt.hidden = true
-- Status
opt.showtabline = 2
opt.laststatus = 2
opt.cmdheight = 1 -- 0 is a problem! https://github.com/neovim/neovim/issues/20380
opt.pumheight = 10 -- pop up menu height
opt.fillchars = { eob = " " }
opt.wildmode = "longest:full,full"
-- Mouse
opt.mouse = "a"

-- Scrolloff
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.whichwrap = "bs"
opt.linebreak = false
opt.list = true

opt.lazyredraw = true
opt.confirm = true
opt.conceallevel = 0

-- Enable break indent
vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"
vim.wo.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Spell language
opt.spelllang = { "de", "en" }

-- Disable certain builtins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_fzf = 1

-- Disable provider warnings in the healthcheck
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
--g.loaded_npm_provider = 0
g.loaded_ruby_provider = 0

-- Python
g.python_host_prog = vim.fn.expand("$HOME/mps/venv/nvim/bin/python")
g.python3_host_prog = vim.fn.expand("$HOME/mps/venv/nvim/bin/python3")

g.NERDTreeQuitOnOpen = 1
g.NERDTreeBookmarkSort = 0
--g.NERDTreeWinPos = "right"
g.WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
g.WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
g.NERDTreeFileExtensionHighlightFullName = 1
g.NERDTreeExactMatchHighlightFullName = 1
g.NERDTreePatternMatchHighlightFullName = 1
g.brown = "905532"
g.aqua = "3AFFDB"
g.blue = "689FB6"
g.darkBlue = "44788E"
g.purple = "834F79"
g.lightPurple = "834F79"
g.red = "AE403F"
g.beige = "F5C06F"
g.yellow = "F09F17"
g.orange = "D4843E"
g.darkOrange = "F16529"
g.pink = "CB6F6F"
g.salmon = "EE6E73"
g.green = "8FAA54"
g.lightGreen = "31B53E"
g.white = "FFFFFF"
g.rspec_red = "FE405F"
g.git_orange = "F54D27"

g.NERDTreeSyntaxEnabledExtensions = { "hbs", "lhs" }
g.NERDTreeSyntaxEnabledExactMatches = { "dropbox", "node_modules", "favicon.ico" }
g.NERDTreeHighlightCursorline = 1

g.NERDTreeDirArrowExpandable = "+"
g.NERDTreeDirArrowCollapsible = "~"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- silence navic warnings
vim.g.navic_silence = true

vim.o.lazyredraw = false
vim.o.fasttty = true
