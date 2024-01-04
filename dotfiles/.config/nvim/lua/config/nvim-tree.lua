local api = require("nvim-tree.api")

-- local function edit_or_open()
-- 	local node = api.tree.get_node_under_cursor()
--
-- 	if node.nodes ~= nil then
-- 		-- expand or collapse folder
-- 		api.node.open.edit()
-- 	else
-- 		-- open file
-- 		api.node.open.edit()
-- 		-- Close the tree if file was opened
-- 		api.tree.close()
-- 	end
-- end
--
-- -- open as vsplit on current node
-- local function vsplit_preview()
-- 	local node = api.tree.get_node_under_cursor()
--
-- 	if node.nodes ~= nil then
-- 		-- expand or collapse folder
-- 		api.node.open.edit()
-- 	else
-- 		-- open file as vsplit
-- 		api.node.open.vertical()
-- 	end
--
-- 	-- Finally refocus on tree if it was lost
-- 	api.tree.focus()
-- end
--
-- -- Git staging -----------
-- local git_add = function()
-- 	local node = api.tree.get_node_under_cursor()
-- 	local gs = node.git_status.file
--
-- 	-- If the current node is a directory get children status
-- 	if gs == nil then
-- 		gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
-- 		    or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
-- 	end
--
-- 	-- If the file is untracked, unstaged or partially staged, we stage it
-- 	if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
-- 		vim.cmd("silent !git add " .. node.absolute_path)
--
-- 		-- If the file is staged, we unstage
-- 	elseif gs == "M " or gs == "A " then
-- 		vim.cmd("silent !git restore --staged " .. node.absolute_path)
-- 	end
--
-- 	api.tree.reload()
-- end
--
--
-- -- Tabs
-- local swap_then_open_tab = function()
-- 	local api = require("nvim-tree.api")
-- 	local node = api.tree.get_node_under_cursor()
-- 	vim.cmd("wincmd l")
-- 	api.node.open.tab(node)
-- end
-- local function open_tab_silent(node)
-- 	local api = require("nvim-tree.api")
--
-- 	api.node.open.tab(node)
-- 	vim.cmd.tabprev()
-- end
--
-- local function change_root_to_global_cwd()
-- 	local api = require("nvim-tree.api")
-- 	local global_cwd = vim.fn.getcwd(-1, -1)
-- 	api.tree.change_root(global_cwd)
-- end
--
-- local function natural_cmp(left, right)
-- 	left = left.name:lower()
-- 	right = right.name:lower()
--
-- 	if left == right then
-- 		return false
-- 	end
--
-- 	for i = 1, math.max(string.len(left), string.len(right)), 1 do
-- 		local l = string.sub(left, i, -1)
-- 		local r = string.sub(right, i, -1)
--
-- 		if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
-- 			local l_number = tonumber(string.match(l, "^[0-9]+"))
-- 			local r_number = tonumber(string.match(r, "^[0-9]+"))
--
-- 			if l_number ~= r_number then
-- 				return l_number < r_number
-- 			end
-- 		elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
-- 			return l < r
-- 		end
-- 	end
-- end
--

-- SETUP ------------------------
-- local status_ok, nvim_tree = pcall(require, "nvim-tree")
-- if not status_ok then
-- 	return
-- end
-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
-- 	return
-- end
--
-- local tree_cb = nvim_tree_config.nvim_tree_callback

require("nvim-tree").setup({

	hijack_cursor = true,
	sync_root_with_cwd = true,
	view = {
		adaptive_size = false,
	},
	renderer = {
		full_name = true,
		group_empty = true,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "signcolumn",
			show = {
				file = true,
				folder = false,
				folder_arrow = false,
				git = true,
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { "help" },
	},
	actions = {
		change_dir = {
			enable = false,
			restrict_above_cwd = true,
		},
		open_file = {
			resize_window = true,
			window_picker = {
				chars = "aoeui",
			},
		},
		remove_file = {
			close_window = false,
		},
	},
	log = {
		enable = false,
		truncate = true,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
	disable_netrw = true,
	hijack_netrw = true,
	update_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "⚑",
			info = "»",
			warning = "▲",
			error = "✘",
		}
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500
	},
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
		side = "left",
		number = false,
		relativenumber = false,
	},

	filters = {
		dotfiles = true,
		custom = {
			"^.git$",
		},
	},
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = true, -- Turn into false from true by default
	},
	-- on_attach = function(bufnr)
	-- 	local function opts(desc)
	-- 		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	-- 	end
	-- 	vim.keymap.set("n", "l", edit_or_open, opts("edit or open"))
	-- 	vim.keymap.set("n", "L", vsplit_preview, opts("Preview"))
	-- 	vim.keymap.set("n", "h", api.tree.close, opts("Close"))
	-- 	vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse"))
	-- 	vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))
	-- 	vim.keymap.set('n', '<C-e>', change_root_to_global_cwd, opts('Change Root To Global CWD'))
	-- end,
})
