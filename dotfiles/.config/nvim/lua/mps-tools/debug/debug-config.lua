-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|

require("dapui").setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.25,
				},
				{
					id = "console",
					size = 0.75,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})

-- require("dapui").setup({
-- 	-- Set icons to characters that are more likely to work in every terminal.
-- 	--    Feel free to remove or use ones that you like more! :)
-- 	--    Don't feel like these are good choices.
-- 	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
-- 	controls = {
-- 		element = "repl",
-- 		enabled = true,
-- 		icons = {
-- 			pause = "⏸",
-- 			play = "▶",
-- 			step_into = "⏎",
-- 			step_over = "⏭",
-- 			step_out = "⏮",
-- 			step_back = "b",
-- 			run_last = "▶▶",
-- 			terminate = "⏹",
-- 			disconnect = "⏏",
-- 		},
-- 	},
-- 	element_mappings = {},
-- 	render = {
-- 		indent = 1,
-- 		max_value_lines = 100,
-- 	},
-- 	floating = {
-- 		border = "single",
-- 		mappings = {
-- 			close = { "q", "<Esc>" },
-- 		},
-- 	},
-- 	sidebar = {
-- 		open_on_start = true,
-- 		elements = {
-- 			-- You can specify which elements to display in the sidebar and their order
-- 			-- "scopes",
-- 			"breakpoints",
-- 			-- "stacks",
-- 			"watches",
-- 		},
-- 		width = 40,
-- 		position = "left",
-- 	},
-- 	tray = {
-- 		open_on_start = true,
-- 		elements = {
-- 			"repl",
-- 			-- "sessions",
-- 			-- "dap-repl",
-- 			"console",
-- 		},
-- 		height = 10,
-- 		position = "bottom",
-- 	},
-- 	force_buffers = true,
-- 	expand_lines = true,
-- 	mappings = {
-- 		-- edit = "e",
-- 		-- expand = { "<CR>", "<2-LeftMouse>" },
-- 		-- open = "o",
-- 		-- remove = "d",
-- 		-- repl = "r",
-- 		-- toggle = "t",
-- 	},
-- })

require("nvim-dap-virtual-text").setup({
	enabled = true, -- enable this plugin (the default)
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = true, -- prefix virtual text with comment string
	only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
	all_references = false, -- show virtual text on all all references of the variable (not only definitions)
	clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
	--- A callback that determines how a variable is displayed or whether it should be omitted
	--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
	--- @param buf number
	--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
	--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
	--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
	--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
	display_callback = function(variable, buf, stackframe, node, options)
		if options.virt_text_pos == "inline" then
			return " = " .. variable.value
		else
			return variable.name .. " = " .. variable.value
		end
	end,
	-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
	virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

	-- experimental features:
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = 81, -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text")

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Install golang specific config
vim.cmd("highlight NvimDapVirtualText guifg=#ff0000")
--vim.cmd("highlight DapStoppedCursorLine guifg=#ff0000 guibg=#0000ff gui=bold") -- RGB Blue
vim.cmd("highlight DapBpLine guifg=#1abc9c guibg=#233745 gui=bold") -- DiagGreen
vim.cmd("highlight DapCurrentLine guifg=#db4b4b guibg=#362c3d gui=bold") -- DiagRed

--vim.cmd("highlight DapStoppedLine guibg=#00ff00")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBpLine", linehl = "DapBpLine", numhl = "DapBpLine" })
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "", texthl = "DapBpLine", linehl = "DapBpLine", numhl = "DapBpLine" }
)
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapBpLine", linehl = "DapBpLine", numhl = "DapBpLine" })
vim.fn.sign_define(
	"DapStopped",
	{ text = "", texthl = "DapCurrentLine", linehl = "DapCurrentLine", numhl = "DapCurrentLine" }
)

vim.g.dap_virtual_text = true

local pythonPath = os.getenv("HOME") .. "/mps/venv/nvim/bin/python"
require("dap-python").setup(pythonPath)
-- table.insert(require("dap").configurations.python, {
-- 	justMyCode = false,
-- 	type = "python",
-- 	request = "launch",
-- 	name = "My custom launch configuration",
-- 	program = "${file}",
-- 	-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- })
