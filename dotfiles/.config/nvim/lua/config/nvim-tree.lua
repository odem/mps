local api = require("nvim-tree.api")

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
			restrict_above_cwd = false,
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
		adaptive_size = false,
	},

	filters = {
		dotfiles = false,
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
