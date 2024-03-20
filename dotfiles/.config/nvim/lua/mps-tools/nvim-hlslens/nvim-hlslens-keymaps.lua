local K = require("mps-core.helpers")

-- hlslens
K.map(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ desc = "hlslens n start" }
)
K.map(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ desc = "hslens N start()" }
)
K.map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { desc = "hlsens * start()" })
K.map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { desc = "hlsens # start()" })
K.map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { desc = "hlsens g* start()" })
K.map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], { desc = "hlsens g# start()" })
