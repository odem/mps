local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local M = {}
function M.find_files_slash()
	local dir = "/"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_root()
	local dir = "/root"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_home()
	local dir = "~"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_mps()
	local dir = "~/mps"
	local opts = themes.get_ivy({
		winblend = 30,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_scratch()
	local dir = "~/mps/scratch"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_repo()
	local dir = "~/mps/repo"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_etc()
	local dir = "/etc"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_var()
	local dir = "/var"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

function M.find_files_log()
	local dir = "/var/log"
	local opts = themes.get_ivy({
		winblend = 10,
		border = true,
		previewer = true,
		shorten_path = true,
		cwd = dir,
		prompt_title = "  " .. dir .. "  ",
		follow = true,
		hidden = true,
	})
	builtin.find_files(opts)
end

return M
