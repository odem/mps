local default_opts = { noremap = true, silent = true }
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

-- Disable Arrow keys
-- map("n", "<up>", "<nop>", {})
-- map("n", "<down>", "<nop>", {})
-- map("n", "<left>", "<nop>", {})
-- map("n", "<right>", "<nop>", {})


-- Quit neovim
map('n', '<leader>q', '<cmd>qa<CR>', default_opts)
-- map('n', '<leader>q', '<cmd>q<CR>', default_opts)
map('n', '<C-q>', '<cmd>qa<CR>', default_opts)
--  close buffer
map('n', '<A-.>', '<cmd>bd<CR>', default_opts)

-- Toggle Relativenumbers
map("n", "<leader>#", "<cmd>set rnu!<CR>", default_opts)

-- venv
map("n", "<A-v>", "<cmd>lua require('swenv.api').pick_venv()<CR>", default_opts)

-- DBUI
map("n", "<A-d>", "<cmd>NvimTreeClose<CR> <BAR><cmd>DBUIToggle<CR>", default_opts)

-- NerdTree
map("n", "<A-e>", "<cmd>NvimTreeToggle<CR>", default_opts)
map("n", "<A-E>", "<cmd>NvimTreeFindFileToggle<CR>", default_opts)
map("n", "<A-f>", "<cmd>NvimTreeFindFile<CR>", default_opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", default_opts)

-- Lsp rename
-- map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Lsp [R]e[n]ame' })

-- Search files
local builtin = require('telescope.builtin')
local ivy = require('telescope.themes').get_ivy()

map('n', '<leader>gf', function() builtin.git_files(ivy) end, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>so', function() builtin.oldfiles(ivy) end, { desc = '[S]earch [O]ld' })
map('n', '<leader>sb', function() builtin.buffers(ivy) end, { desc = '[S]earch [B]uffers' })
map('n', '<leader>sz', function() builtin.current_buffer_fuzzy_find(ivy) end, { desc = '[S]earch fu[Z]zy' })
map('n', '<leader><space>', function() builtin.find_files(ivy) end, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', function() builtin.help_tags(ivy) end, { desc = '[S]earch [H]elp' })
map('n', '<leader>sr', function() builtin.registers(ivy) end, { desc = '[S]earch [R]egisters' })
map('n', '<leader>sm', function() builtin.keymaps(ivy) end, { desc = '[S]earch key[M]aps' })
map('n', '<leader>sw', function() builtin.grep_string(ivy) end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', function() builtin.live_grep(ivy) end, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sc', function() builtin.colorscheme(ivy) end, { desc = '[S]earch [C]olorscheme' })
map('n', '<leader>sd', function() builtin.diagnostics(ivy) end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sj', function() builtin.jumplist(ivy) end, { desc = '[S]earch [J]umps' })

-- Custom telescope modules
map('n', '<leader>sfroot', function() require("custom.telescope").find_files_root() end, { desc = '[S]earch [F]iles [R]oot' })
map('n', '<leader>sfh', function() require("custom.telescope").find_files_home() end, { desc = '[S]earch [F]iles [H]ome' })
map('n', '<leader>sfm', function() require("custom.telescope").find_files_mps() end, { desc = '[S]earch [F]iles [M]ps' })
map('n', '<leader>sfs', function() require("custom.telescope").find_files_scratch() end, { desc = '[S]earch [F]iles [S]cratch' })
map('n', '<leader>sfr', function() require("custom.telescope").find_files_repo() end, { desc = '[S]earch [F]iles [R]epositories' })
map('n', '<leader>sfe', function() require("custom.telescope").find_files_etc() end, { desc = '[S]earch [F]iles /[E]tc' })
map('n', '<leader>sfv', function() require("custom.telescope").find_files_var() end, { desc = '[S]earch [F]iles /[V]ar' })
map('n', '<leader>sfl', function() require("custom.telescope").find_files_log() end, { desc = '[S]earch [F]iles /var/[L]og' })


-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>sde', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>sdq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Fugitive
map("n", "<leader>gs", vim.cmd.Git, { desc = "Git cmd" })

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
map("n", "hx", mark.add_file)
map("n", "hm", ui.toggle_quick_menu)
map("n", "hn", ui.nav_next)
map("n", "hp", ui.nav_prev)
map("n", "<leader>1", function() ui.nav_file(1) end)
map("n", "<leader>2", function() ui.nav_file(2) end)
map("n", "<leader>3", function() ui.nav_file(3) end)
map("n", "<leader>4", function() ui.nav_file(4) end)

-- splits
map("n", "<leader>-", ":split<Space>", default_opts)
map("n", "<leader>_", ":vsplit<Space>", default_opts)

-- Better split navigation
map('n', '<S-Left>', '<C-w>h', default_opts)
map('n', '<S-Down>', '<C-w>j', default_opts)
map('n', '<S-Up>', '<C-w>k', default_opts)
map('n', '<S-Right>', '<C-w>l', default_opts)

-- Resize splits
map("n", "<", ":vertical resize+5<CR>", default_opts)
map("n", ">", ":vertical resize-5<CR>", default_opts)
map("n", "_", ":horizontal resize+5<CR>", default_opts)
map("n", "-", ":horizontal resize-5<CR>", default_opts)

-- Navigate buffers
map("n", "<S-c>", ":bnext<CR>", default_opts)
map("n", "<S-x>", ":bprevious<CR>", default_opts)

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
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Better pasting
map("i", "<C-c>", "<Esc>", default_opts)

-- Stay in indent mode
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- toggleterm
map("n", "<leader>üü", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })
map("n", "<leader>üp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true })
map("n", "<leader>ül", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
map("n", "<leader>üt", "<cmd>lua _NCDU_TOGGLE()<CR>", { noremap = true, silent = true })
map("n", "<leader>üb", "<cmd>lua _BPYTOP_TOGGLE()<CR>", { noremap = true, silent = true })

-- Shell
map("n", "<leader>bss", "<cmd>15sp term://bash<CR>i", default_opts)
map("n", "<leader>bsx+", "<cmd>!chmod +x %:p<CR><CR>", default_opts)
map("n", "<leader>bsx-", "<cmd>!chmod -x %:p <CR><CR>", default_opts)
map("n", "<leader>bsrb", "<cmd>!bash -c %:p<CR>", default_opts)
map("n", "<leader>bsrp", "<cmd>!python3 %:p<CR>", default_opts)
map("n", "<leader>bscp", ":!cp %:p<space>", default_opts)
map("n", "<leader>bsmv", ":!mv %:p", default_opts)

-- BrowserSearch
map("n", "<leader>Ä", "<cmd>BrowserSearch<CR>", default_opts)
map("v", "<leader>ä", "<Plug>SearchVisual", default_opts)


