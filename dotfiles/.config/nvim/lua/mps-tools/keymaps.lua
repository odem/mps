local K = require("mps-core.helpers")

-- -- Vim-rest-client
K.map("n", "<leader>xr", ":call VrcQuery()<CR>", { desc = "Query rest" })

-- Neogen
K.map("n", "gnc", "<cmd>Neogen<CR>", { desc = "Insert Neogen comment" })

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

-- Overseer
K.map("n", "<a-t>", "<Cmd>OverseerToggle<CR>", { desc = "overseer [t]oggle" })
K.map("n", "<Leader>ovt", "<Cmd>OverseerToggle<CR>", { desc = "[ov]erseer [t]oggle" })
K.map("n", "<Leader>ovo", "<Cmd>OverseerOpen<CR>", { desc = "[ov]erseer [o]pen" })
K.map("n", "<Leader>ovc", "<Cmd>OverseerClose<CR>", { desc = "[ov]erseer [c]lose" })
K.map("n", "<Leader>ovr", "<Cmd>OverseerRun<CR>", { desc = "[ov]erseer [r]un" })
K.map("n", "<Leader>ovi", "<Cmd>OverseerInfo<CR>", { desc = "[ov]erseer [i]nfo" })
K.map("n", "<Leader>ovb", "<Cmd>OverseerBuild<CR>", { desc = "[ov]erseer [b]uild" })

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
