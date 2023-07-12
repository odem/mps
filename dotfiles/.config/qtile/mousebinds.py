from libqtile.config import Click, Drag
from libqtile.lazy import lazy

from globals import m, resizeAmount


class MpsMousebinds:
    def init_mousebinds(self):
        return [
            Drag(
                m,
                "Button1",
                lazy.window.set_position_floating(),
                start=lazy.window.get_position(),
            ),
            Drag(
                m,
                "Button2",
                lazy.window.set_size_floating(),
                start=lazy.window.get_position(),
            ),
            Click(
                m,
                "Button4",
                lazy.window.resize_floating(resizeAmount, resizeAmount),
            ),
            Click(
                m,
                "Button5",
                lazy.window.resize_floating(-resizeAmount, -resizeAmount),
            ),
            Click(m, "Button3", lazy.window.bring_to_front()),
        ]
