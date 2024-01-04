local leader = "SPC"
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
-- Set header
dashboard.section.header.val = {
	"                                                                         ",
	"                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⠋⠉⠉⠻⢦⣄⠀⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⠾⠉⠉⠉⠛⢷⣄⠀⠀⠀⠀⠈⡻⣆⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠶⠞⠛⠻⣧⡀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⣀⣀⣹⢹⡇⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠀⣀⣠⠞⠋⠀⠀⠀⠀⠀⠈⢻⠀⠀⢈⣩⣤⣼⣧⡤⠶⠛⠉⠉⠙⠻⣥⡀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⣠⢞⡿⠿⠗⠶⣦⠀⠀⠀⢀⣴⠆⢸⠇⣾⣏⠉⠉⠹⠏⢳⠳⠄⠀⠀⠀⢸⠜⣇⠀⠀⠀⠀                  ",
	"                  ⠀⠀⣾⢃⠀⠀⠀⠀⠀⢸⡄⠀⠀⠻⠋⠀⢸⡀⢿⡈⠳⠤⠤⠴⠚⠀⠀⠀⠀⢀⡾⠀⢻⠀⠀⠀⠀                  ",
	"                  ⠀⢠⣯⡸⡄⠀⠀⠀⠀⠀⣷⡀⠀⠀⠀⠀⣿⡇⠈⠳⣦⣄⡀⠀⠀⠀⠀⠀⣠⡾⣡⠀⠸⣇⠀⠀⠀                  ",
	"                  ⠀⣿⣃⠻⣧⠀⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⢸⡇⠀⠀⠀⢸⠇⠀⢀⣿⣿⣉⣁⣴⠞⠃⠀⠀⠹⣧⠀                  ",
	"                  ⠀⣿⡌⠙⢻⣧⠀⠀⠀⠀⣠⣽⠀⠀⠀⠀⢸⡇⠀⠀⠀⢸⡇⠀⢸⣿⣿⣉⣁⣴⠞⠃⠀⠀⢹⣧⠀                  ",
	"                  ⠀⢹⡷⢀⠀⠻⣷⣀⣰⠯⣽⡏⠀⣀⣴⢶⣾⡷⠚⠋⢻⣾⠿⠿⠛⠻⠦⣄⡀⠀⠀⠀⢀⠔⢸⣿⠀                  ",
	"                  ⠀⢸⡇⣼⡄⠀⠙⠿⠷⠿⠿⣷⣿⣤⣤⣴⣿⣧⣄⣤⣾⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡏⠀⣾⡏⠀                  ",
	"                  ⠀⠘⣿⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⠏⣿⡏⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡟⠀⠀                  ",
	"                  ⠀⠀⠹⣧⣇⠀⠀⠀⠀⠀⠀⠀⠀⡜⠁⠀⢯⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡜⢡⣿⠏⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⢻⡞⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣄⠀⠀⠀⠀⠀⠀⠀⢀⡴⠃⣰⣿⠋⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⢿⡜⢦⡀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠘⢮⡢⣄⠀⠀⠀⠀⣰⢏⣀⣾⡟⠁⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠸⣧⠈⣇⠀⠀⠀⠀⠀⠉⠙⠒⠢⠤⣄⡙⠢⣼⠲⠤⣾⠇⢠⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⢻⣆⡈⠣⠤⠴⠶⠒⠒⠒⠒⠲⠶⠤⣄⣀⣀⣀⣤⠖⢲⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠘⣿⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠒⠒⠒⠂⠛⢚⠛⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀                  ",
	"                  ⠀⠀⠀⠀⠀⠀⠸⣧⢱⡀⠀⠀⠐⠲⣄⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀                  ",
	"                                                                         "
	-- "                   -- a M3sS@g3 2 tHe P@raN0iD --                        ",
	-- "++++++++++[>+>+++>+++++++>++++++++++<<<<-]>>>>-----------.++++++++++++.++",
	-- "++++++++++++.<<++++++++++++++.------------.>>----------.<<.>>--------.+++",
	-- "+++++++++.<<.>>------------.<<.>>++.+++++++++++++++.---------.++++.----.+",
	-- "++++.-------------.+++++++++++.<<++++++++++++++.--------------.>+++++++.>",
	-- "+++++++++++++.<<.>++++++++++++++++++++++.>-------.<++++++.++++.--------.<",
	-- ".>++++.>+.<<.>>+.<-.-------.>.<<.>>-----.<+++++.<.>---.>++++++.---.<+++++",
	-- "+.>---.++++.<.>+.+++++.<<++++++++++++++.--------------.+++++++++++++++++.",
	-- "++++++++.-.--.<++++++++++++++++++++++.>>---------------------.>----------",
	-- "-------.---.<<<.>>-------.>.+++++++++.++++++.-----.+++.                  ",
}

local if_nil = vim.F.if_nil
--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
dashboard.button = function(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 73,
		align_shortcut = "right",
		hl_shortcut = "EcovimPrimary",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		-- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
		local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end
-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("n", "📄 >                            New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("e", "📁 >                            Explore",
		":NvimTreeToggle<CR> | :wincmd p<CR> | :close<CR>"),
	dashboard.button("f", "🔍 >                            Find file",
		":cd $HOME/Workspace | Telescope find_files<CR>"),
	dashboard.button("r", "⌛ >                            Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("h", "🚑 >                            Health", ":checkhealth<CR>"),
	dashboard.button("s", "🔧 >                            Settings",
		":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
	dashboard.button("t", "💻 >                            Terminal", ":ToggleTerm<CR>"),
	dashboard.button("l", "😴 >                            Lazy", ":Lazy! sync<CR>"),
	dashboard.button("m", "🔨 >                            Mason", ":Mason<CR>"),
	dashboard.button("q", "❌ >                            Quit", ":qa<CR>"),
}
dashboard.section.buttons.opts = { spacing = 0 }

local hi_top_section = {
	type = "text",
	val = "┌───────────────────────────────────────────────────────────────────────┐",
	opts = {
		position = "center",
		hl = "Type"
	}
}

local hi_middle_section = {
	type = "text",
	val = " ",
	opts = {
		position = "center",
		hl = "EcovimHeaderInfo"
	}
}

local hi_bottom_section = {
	type = "text",
	val = " ",
	opts = {
		position = "center",
		hl = "Type"
	}
}

dashboard.section.footer = {
	type = "text",
	val = "└───────────────────────────────────────────────────────────────────────┘",
	opts = {
		position = "center",
		hl = "Type"
	},
}


local section = {
	header = dashboard.section.header,
	hi_top_section = hi_top_section,
	hi_middle_section = hi_middle_section,
	hi_bottom_section = hi_bottom_section,
	buttons = dashboard.section.buttons,
	footer = dashboard.section.footer,
}
local opts = {
	layout = {
		{ type = "padding", val = 0 },
		section.header,
		{ type = "padding", val = 5 },
		section.hi_top_section,
		section.hi_middle_section,
		{ type = "padding", val = 0 },
		section.buttons,
		{ type = "padding", val = 0 },
		section.hi_bottom_section,
		section.footer,
	},
	opts = {
		margin = 0
	},
}


-- Setup
alpha.setup(opts)
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "alpha_tabline",
	pattern = "alpha",
	command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
	group = "alpha_tabline",
	pattern = "alpha",
	callback = function()
		vim.api.nvim_create_autocmd("BufUnload", {
			group = "alpha_tabline",
			buffer = 0,
			command = "set showtabline=2 ruler laststatus=3",
		})
	end,
})
