local K = require("mps-core.helpers")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
K.map("n", "hx", mark.add_file)
K.map("n", "hm", ui.toggle_quick_menu)
K.map("n", "hn", ui.nav_next)
K.map("n", "hp", ui.nav_prev)
K.map("n", "11", function()
	ui.nav_file(1)
end)
K.map("n", "22", function()
	ui.nav_file(2)
end)
K.map("n", "33", function()
	ui.nav_file(3)
end)
K.map("n", "44", function()
	ui.nav_file(4)
end)
K.map("n", "55", function()
	ui.nav_file(5)
end)
