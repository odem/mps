from libqtile.config import ScratchPad, DropDown
from globals import tm


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
                ],
            ),
        )
