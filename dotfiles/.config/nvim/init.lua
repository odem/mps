local coreplugs = require("mps-core.init").getplugins()
local toolplugs = require("mps-tools.init").getplugins()
local uiplugs = require("mps-ui.init").getplugins()

require("mps-core.helpers").initLazy()
require("lazy").setup({ coreplugs, toolplugs, uiplugs }, {})

-- Core
require("mps-core.init").configure()
require("mps-tools.init").configure()
require("mps-ui.init").configure()
