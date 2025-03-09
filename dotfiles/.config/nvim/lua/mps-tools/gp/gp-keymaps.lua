-- Chat commands
vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", {desc="New Chat"})
vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", {desc="Toggle Chat"})
vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", {desc="Chat Finder"})

vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", {desc="Visual Chat New"})
vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", {desc="Visual Chat Paste"})
vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", {desc="Visual Toggle Chat"})

vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", {desc="New Chat split"})
vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", {desc="New Chat vsplit"})
vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", {desc="New Chat tabnew"})

vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", {desc="Visual Chat New split"})
vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", {desc="Visual Chat New vsplit"})
vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", {desc="Visual Chat New tabnew"})

-- Prompt commands
vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", {desc="Inline Rewrite"})
vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", {desc="Append (after)"})
vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", {desc="Prepend (before)"})

vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", {desc="Visual Rewrite"})
vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", {desc="Visual Append (after)"})
vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", {desc="Visual Prepend (before)"})
vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", {desc="Implement selection"})

vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", {desc="Popup"})
vim.keymap.set({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", {desc="GpEnew"})
vim.keymap.set({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", {desc="GpNew"})
vim.keymap.set({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", {desc="GpVnew"})
vim.keymap.set({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", {desc="GpTabnew"})

vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", {desc="Visual Popup"})
vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", {desc="Visual GpEnew"})
vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", {desc="Visual GpNew"})
vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", {desc="Visual GpVnew"})
vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", {desc="Visual GpTabnew"})

vim.keymap.set({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", {desc="Toggle Context"})
vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", {desc="Visual Toggle Context"})

vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", {desc="Stop"})
vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", {desc="Next Agent"})

-- optional Whisper commands with prefix <C-g>w
vim.keymap.set({ "n", "i" }, "<C-g>ww", "<cmd>GpWhisper<cr>", {desc="Whisper"})
vim.keymap.set("v", "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", {desc="Visual Whisper"})

vim.keymap.set({ "n", "i" }, "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", {desc="Whisper Inline Rewrite"})
vim.keymap.set({ "n", "i" }, "<C-g>wa", "<cmd>GpWhisperAppend<cr>", {desc="Whisper Append (after)"})
vim.keymap.set({ "n", "i" }, "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", {desc="Whisper Prepend (before) "})

vim.keymap.set("v", "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", {desc="Visual Whisper Rewrite"})
vim.keymap.set("v", "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", {desc="Visual Whisper Append (after)"})
vim.keymap.set("v", "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", {desc="Visual Whisper Prepend (before)"})

vim.keymap.set({ "n", "i" }, "<C-g>wp", "<cmd>GpWhisperPopup<cr>", {desc="Whisper Popup"})
vim.keymap.set({ "n", "i" }, "<C-g>we", "<cmd>GpWhisperEnew<cr>", {desc="Whisper Enew"})
vim.keymap.set({ "n", "i" }, "<C-g>wn", "<cmd>GpWhisperNew<cr>", {desc="Whisper New"})
vim.keymap.set({ "n", "i" }, "<C-g>wv", "<cmd>GpWhisperVnew<cr>", {desc="Whisper Vnew"})
vim.keymap.set({ "n", "i" }, "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", {desc="Whisper Tabnew"})

vim.keymap.set("v", "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", {desc="Visual Whisper Popup"})
vim.keymap.set("v", "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", {desc="Visual Whisper Enew"})
vim.keymap.set("v", "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", {desc="Visual Whisper New"})
vim.keymap.set("v", "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", {desc="Visual Whisper Vnew"})
vim.keymap.set("v", "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", {desc="Visual Whisper Tabnew"})
