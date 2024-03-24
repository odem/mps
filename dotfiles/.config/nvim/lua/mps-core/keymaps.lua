local K = require("mps-core.helpers")

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quit neovim
K.map("n", "<C-q>", "<cmd>wqa<CR>", { desc = "Write all and quit" })

-- Files, Buffers
K.map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save file" })
K.map({ "i", "v", "n", "s" }, "<A-s>", "<cmd>source %<cr><Esc>", { desc = "Source file" })
K.map("n", "<A-.>", "<cmd>bd<CR>", { desc = "Close current buffer" })

-- Toggle Relativenumbers
K.map("n", "<leader>#", "<cmd>set rnu!<CR>", { desc = "Toggle line numbers" })
-- splits
K.map("n", "<leader>-", ":split<Space>", { desc = "Split horizontal" })
K.map("n", "<leader>_", ":vsplit<Space>", { desc = "Split vertical" })

-- Better split navigation
K.map("n", "<S-Left>", "<C-w>h", { desc = "WindowMove left" })
K.map("n", "<S-Down>", "<C-w>j", { desc = "WindowMove down" })
K.map("n", "<S-Up>", "<C-w>k", { desc = "WindowMove up" })
K.map("n", "<S-Right>", "<C-w>l", { desc = "WindowMove right" })
K.map("n", "<S-h>", "<C-w>h", { desc = "WindowMove left" })
K.map("n", "<S-j>", "<C-w>j", { desc = "WindowMove down" })
K.map("n", "<S-k>", "<C-w>k", { desc = "WindowMove up" })
K.map("n", "<S-l>", "<C-w>l", { desc = "WindowMove right" })

-- Resize splits
K.map("n", "<", ":vertical resize+5<CR>", { desc = "Vertical WindowSize +5" })
K.map("n", ">", ":vertical resize-5<CR>", { desc = "Vertical WindowSize -5" })
K.map("n", "_", ":horizontal resize+5<CR>", { desc = "Horizontal WindowSize +5" })
K.map("n", "-", ":horizontal resize-5<CR>", { desc = "Horizontal WindowSize -5" })

-- Navigate buffers
K.map("n", "<S-x>", ":bnext<CR>", { desc = "Next buffer" })
K.map("n", "<S-y>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Move lines
K.map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
K.map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
K.map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
K.map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
K.map("v", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move down" })
K.map("v", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move up" })
K.map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move down" })
K.map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move up" })

-- -- Search
K.map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
K.map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Better pasting
K.map("i", "<C-c>", "<Esc>", { desc = "Rebind Esc to <C-c>" })

-- COPY: Normal/Visual delete/change into nirvana
K.map("n", "d", '"_d', { desc = "d->Nirvana", noremap = true, silent = true })
K.map("n", "D", '"_D', { desc = "D->Nirvana", noremap = true, silent = true })
K.map("n", "c", '"_c', { desc = "c->Nirvana", noremap = true, silent = true })
K.map("n", "C", '"_C', { desc = "C->Nirvana", noremap = true, silent = true })
K.map("x", "d", '"_d', { desc = "d->Nirvana", noremap = true, silent = true })
K.map("x", "D", '"_D', { desc = "D->Nirvana", noremap = true, silent = true })
K.map("x", "c", '"_c', { desc = "c->Nirvana", noremap = true, silent = true })
K.map("x", "C", '"_C', { desc = "C->Nirvana", noremap = true, silent = true })

-- Stay in indent mode
K.map("v", "<", "<gv", { desc = "Indent left visual selection" })
K.map("v", ">", ">gv", { desc = "Indent right visual selection" })
-- Shell
K.map("n", "<leader>bss", "<cmd>15sp term://bash<CR>i", { desc = "[b]a[s]h split [s]hell" })
K.map("n", "<leader>bs+x", "<cmd>!chmod +x %:p<CR><CR>", { desc = "[b]a[s]h [c]hmod [+][x]" })
K.map("n", "<leader>bsx-", "<cmd>!chmod -x %:p <CR><CR>", { desc = "[b]a[s]h [c]hmod [-][x]" })
K.map("n", "<leader>bsrb", "<cmd>!bash -c %:p<CR>", { desc = "[b]a[s]h [r]un in [b]ash" })
K.map("n", "<leader>bsrp", "<cmd>!python3 %:p<CR>", { desc = "[b]a[s]h [r]un in [p]ython" })
K.map("n", "<leader>bscp", ":!cp %:p<space>", { desc = "[b]a[s]h [cp]" })
K.map("n", "<leader>bsmv", ":!mv %:p", { desc = "[b]a[s]h [mv]" })
-- Remove words with Backspace and delete
K.map("n", "<BS>", "<Nop>")

-- Delete Iwth Delete and backspace
K.map("n", "<S-BS>", ":call DeleteConditionallyLeft()<CR>", { desc = "Delete to left" })
K.map("i", "<S-BS>", "<C-o>:call DeleteConditionallyLeft()<CR>", { desc = "Delete to left" })
K.map("n", "<S-Delete>", ":call DeleteConditionallyRight()<CR>", { desc = "Delete to right" })
K.map("i", "<S-Delete>", "<C-o>:call DeleteConditionallyRight()<CR>", { desc = "Delete to right" })

-- Mason
K.map("n", "<leader>mm", "<cmd>Mason<CR>", { desc = "Open [m]ason" })
-- Lazy
K.map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open [l]azy" })
-- Fugitive
K.map("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive Git" })
-- venv
K.map("n", "<A-v>", "<cmd>lua require('swenv.api').pick_venv()<CR>", { desc = "Switch Python env" })
-- BrowserSearch
K.map("n", "<leader>Ä", "<cmd>BrowserSearch<CR>", { desc = "Search word via searchprovider" })
K.map("v", "<leader>ä", "<Plug>SearchVisual", { desc = "Search Visual" })

-- END OF ACCEPTED

-- OLD KEYBINDS
-------------------------------------------------------------------------------
-- Disable Arrow keys
-- map("n", "<up>", "<nop>", {})
-- map("n", "<down>", "<nop>", {})
-- map("n", "<left>", "<nop>", {})
-- map("n", "<right>", "<nop>", {})
--
--
--
--
--
--
--
