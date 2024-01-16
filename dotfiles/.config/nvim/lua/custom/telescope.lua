-- local should_reload = true
-- local reloader = function()
-- 	if should_reload then
-- 		RELOAD("plenary")
-- 		RELOAD("telescope")
-- 	end
-- end

local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local M = {}
function M.find_files_slash()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "/",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_home()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "~",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_mps()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "~/mps",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_scratch()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "~/mps/scratch",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_repo()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "~/mps/repo",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_etc()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "/etc",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_var()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "/var",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end
function M.find_files_root()
	local opts = themes.get_ivy {
		winblend = 10,
		border = true,
		previewer= true,
		shorten_path= true,
		cwd = "/var/log",
		follow = true,
		hidden = true,
	}
	builtin.find_files(opts)
end

return M
