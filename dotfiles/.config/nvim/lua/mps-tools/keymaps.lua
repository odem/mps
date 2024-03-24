local K = require("mps-core.helpers")

-- Neogen
K.map("n", "gnc", "<cmd>Neogen<CR>", { desc = "Insert Neogen comment" })

-- Neoformat
K.map("n", "gnf", "<cmd>Neoformat<CR>", { desc = "Format with Neoformat" })

-- Neogen
K.map("n", "gso", "<cmd>SymbolsOutline<CR>", { desc = "Toggle Symbol Outliner" })

-- toggleterm
K.map("n", "<leader>üü", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "ToggleTerm Htop" })
K.map("n", "<leader>üp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "ToggleTerm Python" })
K.map("n", "<leader>ül", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "ToggleTerm lazygit" })
K.map("n", "<leader>ün", "<cmd>lua _NCDU_TOGGLE()<CR>", { desc = "ToggleTerm ncdu" })
K.map("n", "<leader>üb", "<cmd>lua _BPYTOP_TOGGLE()<CR>", { desc = "ToggleTerm bpytop" })

-- noh
K.map("n", "<Leader>l", "<Cmd>noh<CR>", { desc = "" })

-- project
K.map(
	"n",
	"<leader>tcpp",
	"<cmd>lua require('telescope').extensions.projects.projects{}<CR>",
	{ desc = "Telescope Project" }
)
K.map("n", "<leader>tcpr", function()
	local project_nvim = require("project_nvim")
	local recent_projects = project_nvim.get_recent_projects()
	print(vim.inspect(recent_projects))
end, { desc = "Recent Projects" })

-- vim-rest-console
K.map("n", "<A-r>", ":call VrcQuery()<CR>", { desc = "Vrc Query ([r]est)" })

-- Yanky
K.map("x", "p", "<Plug>(YankyPutAfter)", { desc = "" })
K.map("x", "P", "<Plug>(YankyPutBefore)", { desc = "" })
K.map("x", "gp", "<Plug>(YankyGPutAfter)", { desc = "" })
K.map("x", "gP", "<Plug>(YankyGPutBefore)", { desc = "" })
K.map("n", "p", "<Plug>(YankyPutAfter)", { desc = "" })
K.map("n", "P", "<Plug>(YankyPutBefore)", { desc = "" })
K.map("n", "gp", "<Plug>(YankyGPutAfter)", { desc = "" })
K.map("n", "gP", "<Plug>(YankyGPutBefore)", { desc = "" })
K.map("n", "<A-x>", "<Plug>(YankyPreviousEntry)", { desc = "" })
K.map("n", "<A-y>", "<Plug>(YankyNextEntry)", { desc = "" })
