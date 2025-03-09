local K = require("mps-core.helpers")
local ov = require("overseer")
local taskAction

taskAction = function(choice, action)
	local chosen = ov.list_tasks(choice)
	if #chosen == 1 then
		print("Executing ", action, " on task ", choice)
		ov.run_action(chosen[1], action)
	else
		print("ArgumentError! Resultlist != 1")
	end
end
function OverseerTaskAction(choice, action)
	return taskAction(choice, action)
end

function OverseerTaskBySelection(action)
	local tasks = ov.list_tasks()

	-- Check if there are any tasks to select
	if #tasks == 0 then
		print("No tasks available to execute.")
		return
	end

	-- Extract the task names for the selection UI
	local taskNames = {}
	for _, task in ipairs(tasks) do
		table.insert(taskNames, task.name)
	end

	-- Let the user choose a task to execute
	vim.ui.select(taskNames, {
		prompt = "Choose a task to execute:",
		format_item = function(item)
			return item
		end,
	}, function(choice, idx)
		-- Execute if choice was made
		if choice then
			taskAction(choice, action)
		else
			print("Task selection cancelled: ", idx)
		end
	end)
end
-- Overseer
K.map("n", "<a-v>", "<Cmd>OverseerToggle<CR>", { desc = "overseer [v]iew toggle" })
K.map("n", "<Leader>ovv", "<Cmd>OverseerToggle<CR>", { desc = "[ov]erseer [t]oggle" })
K.map("n", "<Leader>ovo", "<Cmd>OverseerOpen<CR>", { desc = "[ov]erseer [o]pen" })
K.map("n", "<Leader>ovc", "<Cmd>OverseerClose<CR>", { desc = "[ov]erseer [c]lose" })
K.map("n", "<Leader>ovr", "<Cmd>OverseerRun<CR>", { desc = "[ov]erseer [r]un" })
K.map("n", "<Leader>ovi", "<Cmd>OverseerInfo<CR>", { desc = "[ov]erseer [i]nfo" })
K.map("n", "<Leader>ovb", "<Cmd>OverseerBuild<CR>", { desc = "[ov]erseer [b]uild" })

-- Tasks
K.map("n", "<Leader>ovtn", "<Cmd>OverseerTaskAction<CR>", { desc = "[ov]erseer [t]ask [n]ew" })
K.map("n", "<Leader>ovl", "<Cmd>OverseerLoadBundle!<CR>", { desc = "[ov]erseer [l]oad bundle" })
K.map("n", "<Leader>ovs", "<Cmd>OverseerSaveBundle<CR>", { desc = "[ov]erseer [s]ave bundle" })
K.map("n", "<A-t>", "<cmd>OverseerTaskAction<CR>", { desc = "Overseer [t]ask action" })
K.map("n", "<A-T>", "<cmd>OverseerQuickAction<CR>", { desc = "Overseer quick [T]ask action" })
