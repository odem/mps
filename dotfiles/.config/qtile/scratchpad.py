from os import environ

from libqtile.config import ScratchPad, DropDown, Key
from libqtile.lazy import lazy
from globals import (
    tm,
    a,
    m,
    modctrl,
    modshift,
    mcs,
)


class MpsScratchpad(object):
    def init_scratchpad(self):
        # Configuration
        height = 0.9
        y_pos = 0.05
        warp_pointer = False
        on_focus_lost_hide = True
        opacity = 1
        cfgPad = {
            "opacity": opacity,
            "on_focus_lost_hide": on_focus_lost_hide,
            "height": height,
            "y": y_pos,
            "warp_pointer": warp_pointer,
        }

        return (
            ScratchPad(
                "scratchpad",
                [
                    DropDown("pavu", "pavucontrol", **cfgPad),
                    DropDown("term", tm, **cfgPad),
                    DropDown("calc", "galculator", **cfgPad),
                    DropDown("htop", "kitty htop", **cfgPad),
                    DropDown("keepass", "keepass2", **cfgPad),
                ],
            ),
        )


class MpsScratchpadKeys(object):
    def init_dropdown_keybindings(self):
        return [
            Key(m, "F4", lazy.group["scratchpad"].dropdown_toggle("pavu")),
            Key(m, "F5", lazy.group["scratchpad"].dropdown_toggle("term")),
            Key(m, "F6", lazy.group["scratchpad"].dropdown_toggle("calc")),
            Key(m, "F7", lazy.group["scratchpad"].dropdown_toggle("htop")),
            Key(m, "F8", lazy.group["scratchpad"].dropdown_toggle("keepass")),
        ]
