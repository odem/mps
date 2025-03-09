local K = require("mps-core.helpers")


-- NERDTree
K.map("n", "<A-e>", "<cmd>NERDTreeToggle<CR>", { desc = "n[e]rdtree toggle" })
K.map("n", "<A-E>", "<cmd>NERDTreeFind<CR>", { desc = "n[e]rdtree find" })
K.map("n", "<leader>eb", "<cmd>Bookmark<CR>", { desc = "n[e]rdtree [b]ookmark" })
