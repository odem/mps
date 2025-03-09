local K = require("mps-core.helpers")

-- Telescope builtin
K.map("n", "<leader>T", "<cmd>Telescope<CR>", { desc = "[t]elescope" })
K.tmap("n", "<leader>tk", "keymaps", "[t]elescope [k]eymaps")
K.tmap("n", "<leader>th", "help_tags", "[t]elescope [h]elp")
K.tmap("n", "<leader>tb", "buffers", "[t]elescope [b]uffers")
K.tmap("n", "<leader>tr", "registers", "[t]elescope [r]egisters")
K.tmap("n", "<leader>tj", "jumplist", "[t]elescope [j]umplist")
K.tmap("n", "<leader>td", "diagnostics", "[t]elescope [d]iagnostics")
K.tmap("n", "<leader>tc", "colorscheme", "[t]elescope [c]olorschemes")
K.tmap("n", "<leader>tgf", "git_files", "[t]elescope [g]it [f]iles")
K.tmap("n", "<leader>tof", "oldfiles", "[t]elescope [o]ld [f]iles")
K.tmap("n", "<leader>tff", "find_files", "[t]elescope [f]ind [f]iles")
K.tmap("n", "<leader>tfz", "current_buffer_fuzzy_find", "[t]elescope [f]ind [f]uzzy")
K.tmap("n", "<leader>tgs", "grep_string", "[t]elescope [g]rep [s]tring")
K.tmap("n", "<leader>tgl", "live_grep", "[t]elescope [g]rep [l]ive")
K.tmap("n", "<leader>/", "buffers", "Telescope buffers")
K.tmap("n", "<leader>?", "current_buffer_fuzzy_find", "Telescope fuzzy buffer")
K.tmap("n", "<leader><leader>", "oldfiles", "Telescope recent files")

-- Telescope custom filesystem search
K.tcmap("n", "<leader>tcs/", "find_files_slash", "[tc] [s]earch [/]")
K.tcmap("n", "<leader>tcso", "find_files_root", "[tc] [s]earch r[o]ot")
K.tcmap("n", "<leader>tcsh", "find_files_home", "[tc] [s]earch [h]ome")
K.tcmap("n", "<leader>tcse", "find_files_etc", "[tc] [s]earch [e]tc")
K.tcmap("n", "<leader>tcsv", "find_files_var", "[tc] [s]earch [v]ar")
K.tcmap("n", "<leader>tcsl", "find_files_log", "[tc] [s]earch [l]og")
K.tcmap("n", "<leader>tcsm", "find_files_mps", "[tc] [s]earch [m]ps")
K.tcmap("n", "<leader>tcsr", "find_files_repo", "[tc] [s]earch [r]epo")
K.tcmap("n", "<leader>tcss", "find_files_scratch", "[tc] [s]earch [s]cratch")

-- Telescope Lsp Keybinds
K.tmap("n", "glr", "lsp_references", "[gt] [l]sp [r]eferences")
K.tmap("n", "gld", "lsp_definitions", "[gt] [l]sp [d]efinitions")
K.tmap("n", "gltd", "lsp_type_definitions", "[gt] [l]sp [t]ype [d]efinitions")
K.tmap("n", "glsd", "lsp_document_symbols", "[gt] [l]sp [d]ocument [s]ymbols")
K.tmap("n", "glsw", "lsp_dynamic_workspace_symbols", "[gt] [l]sp [w]orkspace [s]ymbols")
K.tmap("n", "glg", "diagnostics", "[gt] dia[g]nostics")

-- Override default lsp bindings
K.tmap("n", "gd", "lsp_definitions", "[gt] [l]sp [d]efinitions")
K.tmap("n", "gr", "lsp_references", "[gt] [l]sp [r]eferences")
