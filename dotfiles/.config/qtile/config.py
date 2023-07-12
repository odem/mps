from mousebinds import MpsMousebinds
from keybinds import MpsKeybinds
from screens import MpsScreens
from floats import MpsFloats
from layouts import MpsLayouts
from groups import MpsGroups
from scratchpad import MpsScratchpad, MpsScratchpadKeys

groups = MpsGroups().init_groups()
layouts = MpsLayouts().init_layouts()
screens = MpsScreens().init_screens()
floating_layout = MpsFloats().init_floats()
mouse = MpsMousebinds().init_mousebinds()
keys = MpsKeybinds().init_keybinds(groups)
groups += MpsScratchpad().init_scratchpad()
keys += MpsScratchpadKeys().init_dropdown_keybindings()
