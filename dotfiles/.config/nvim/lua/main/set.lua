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

-- Make neovim use the system clipboard
opt.clipboard = 'unnamedplus'

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
opt.foldcolumn = '1'

opt.updatetime = 200
opt.timeout = true
opt.timeoutlen = 300
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.backup = false
opt.writebackup = false
opt.autochdir = true

opt.filetype = "on"
opt.encoding = "utf-8"
opt.hidden = true
-- Status
opt.showtabline = 1
opt.laststatus = 1
opt.cmdheight = 1  -- 0 is a problem! https://github.com/neovim/neovim/issues/20380
opt.pumheight = 10 -- pop up menu height
opt.fillchars = { eob = ' ' }
opt.wildmode = "longest:full,full"
-- Mouse
opt.mouse = 'a'

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
vim.wo.signcolumn = 'yes'
vim.wo.colorcolumn = "79"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Spell language
opt.spelllang = { "en", "de" }

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
g.loaded_npm_provider = 0
g.loaded_ruby_provider = 0

g.NERDTreeQuitOnOpen = 1
g.NERDTreeBookmarkSort = 0



-- g.tpipeline_autoembed = 1
-- g.tpipeline_statusline = '%!tpipeline#stl#line()'
-- g.tpipeline_statusline = '%f'
-- g.tpipeline_clearstl = 1
