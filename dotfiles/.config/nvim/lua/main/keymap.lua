local default_opts = { noremap = true, silent = true }
--local map = vim.api.nvim_set_keymap



local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quit neovim
map('n', '<leader>Q', '<cmd>qa<CR>', default_opts)
map('n', '<leader>q', '<cmd>q<CR>', default_opts)
map('n', '<C-Q>', '<cmd>q<CR>', default_opts)
--  close buffer
map('n', '<A-.>', '<cmd>bd<CR>', default_opts)

-- Toggle Relativenumbers
map("n", "<leader>#", "<cmd>set rnu!<CR>", default_opts)

-- venv
map("n", "<A-v>", "<cmd>lua require('swenv.api').pick_venv()<CR>", default_opts)
-- Telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<c-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("grep > ") })
end)

-- Search files
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Lsp rename
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Lsp [R]e[n]ame' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>M", mark.add_file)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

-- undotree
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- splits
map("n", "<leader>-", ":split<Space>", default_opts)
map("n", "<leader>_", ":vsplit<Space>", default_opts)

-- Better split navigation
map('n', '<S-Left>', '<C-w>h', default_opts)
map('n', '<S-Down>', '<C-w>j', default_opts)
map('n', '<S-Up>', '<C-w>k', default_opts)
map('n', '<S-Right>', '<C-w>l', default_opts)

-- Resize splits
-- map('n', '<A-l>', '<cmd>vertical resize +1<CR>', opts)
-- map('n', '<A-h>', '<cmd>vertical resize -1<CR>', opts)
-- map('n', '<A-k>', '<cmd>resize +1<CR>', opts)
-- map('n', '<A-j>', '<cmd>resize -1<CR>', opts)

-- Resize splits
map("n", "<", ":vertical resize+5<CR>", default_opts)
map("n", ">", ":vertical resize-5<CR>", default_opts)
map("n", "_", ":horizontal resize+5<CR>", default_opts)
map("n", "-", ":horizontal resize-5<CR>", default_opts)

-- Buffers
--map('n', '<Space>', '<Nop>', { silent = true })
--map('v', '<Space>', '<Nop>', { silent = true })

-- Navigate buffers
map("n", "<S-c>", ":bnext<CR>", default_opts)
map("n", "<S-x>", ":bprevious<CR>", default_opts)

-- Quick write
--map('n', '<leader>w', '<cmd>w<CR>', default_opts)

-- Lazy keymap
--vim.keymap.set('n', '<leader>ll', function() return require('lazy').home() end)
--vim.keymap.set('n', '<leader>lu', function() return require('lazy').update() end)
--vim.keymap.set('n', '<leader>ls', function() return require('lazy').sync() end)
--vim.keymap.set('n', '<leader>lL', function() return require('lazy').log() end)
--vim.keymap.set('n', '<leader>lc', function() return require('lazy').clean() end)
--vim.keymap.set('n', '<leader>lp', function() return require('lazy').profile() end)

-- lsp
map('n', '<leader>cr', "<cmd>LspRestart<cr>", { desc = "LspRestart" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move down" })
map("v", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move up" })
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move down" })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move up" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<leader>fn", "<cmd>e new<cr>", { desc = "New File" })

-- Search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- Remap for dealing with word wrap (overlaps regular vim bindings)
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts)
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts)

-- Delete next line to current row
-- map('n', "J", "mzJ`z", opts)

-- Half page up or down
--map('n', "<C-d>", "<C-d>zz", opts)
--map('n', "<C-u>", "<C-u>zz", opts)

-- ?
-- map('n', "n", "nzzzv", opts)
-- map('n', "N", "Nzzzv", opts)

-- Better pasting
map('x', "<leader>p", "\"_dP", default_opts)
map("n", "<leader>d", "\"_d", default_opts)
map("v", "<leader>d", "\"_d", default_opts)
map("i", "<C-c>", "<Esc>", default_opts)

-- Clipboard
map("n", "<leader>y", "\"+y", default_opts)
map("v", "<leader>y", "\"+y", default_opts)
map("n", "<leader>Y", "\"+Y", default_opts)

-- Replace current word
-- map("n", "<leader>rn", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>", default_opts)
--map("n", "<leader>sen", ":setlocal spell! spelllang=en_us<CR>", default_opts)
--map("n", "<leader>sde", ":setlocal spell! spelllang=de_de<CR>", default_opts)

-- NERDTree
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
map("n", "<A-e>", "<cmd>NvimTreeToggle<CR>", default_opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", default_opts)
map("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", default_opts)
map("n", "<A-f>", "<cmd>NvimTreeFocus<CR>", default_opts)
map("n", "<leader>f", "<cmd>NvimTreeFocus<CR>", default_opts)
-- map("n", "bb", "<cmd>Bookmark<CR>", default_opts)



-- Stay in indent mode
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- Trouble
--map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", default_opts)
--map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", default_opts)
--map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", default_opts)
--map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", default_opts)
--map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", default_opts)
--map("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", default_opts)

-- toggleterm
vim.api.nvim_set_keymap("n", "<leader>üü", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>üp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ül", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>üt", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>üb", "<cmd>lua _BPYTOP_TOGGLE()<CR>", { noremap = true, silent = true })

-- Shell
map("n", "<leader>ss", "<cmd>15sp term://bash<CR>i", default_opts)
map("n", "<leader>sx+", "<cmd>!chmod +x %:p<CR><CR>", default_opts)
map("n", "<leader>sx-", "<cmd>!chmod -x %:p <CR><CR>", default_opts)
map("n", "<leader>srb", "<cmd>!bash -c %:p<CR>", default_opts)
map("n", "<leader>srp", "<cmd>!python3 %:p<CR>", default_opts)
map("n", "<leader>scp", ":!cp %:p<space>", default_opts)
map("n", "<leader>smv", ":!mv %:p", default_opts)

-- BrowserSearch
map("n", "<leader>Ä", "<cmd>BrowserSearch<CR>", default_opts)
--map("n", "<leader>ä", "<Plug>SearchNormal", opts)
map("v", "<leader>ä", "<Plug>SearchVisual", default_opts)

-- dadbod
map("n", "<A-d>", "<cmd>DBUIToggle<CR>", default_opts)
