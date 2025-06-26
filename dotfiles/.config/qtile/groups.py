from libqtile.config import Group, Match


class MpsGroups(object):
    def init_groups(self):
        return [
            Group("1", label="1  ", matches=[], layout="monadtall"),
            Group(
                "2",
                label="2  ",
                matches=[Match(wm_class="Thunar")],
                layout="treetab",
            ),
            Group(
                "3",
                label="3  ",
                matches=[Match(wm_class="Firefox-esr")],
                layout="max",
            ),
            Group("4", label="4 󰦖 ", matches=[], layout="monadtall"),
            Group(
                "5",
                spawn="gnome-system-monitor",
                label="5 󰨇 ",
                matches=[
                    Match(wm_class="Gnome-system-monitor"),
                    Match(wm_class="Thunar"),
                ],
                layout="monadwide",
            ),
            Group(
                "6",
                label="6 󰍺 ",
                matches=[Match(wm_class="qemu")],
                layout="monadtall",
            ),
            Group(
                "7",
                label="7  ",
                matches=[
                    Match(wm_class="thunderbird-default"),
                    Match(wm_class="zoom"),
                    Match(wm_class="mumble"),
                ],
                layout="treetab",
            ),
            Group(
                "8",
                label="8  ",
                matches=[
                    Match(wm_class="steam"),
                    Match(wm_class="steamwebhelper"),
                    Match(wm_class="lutris"),
                ],
                layout="max",
            ),
            Group(
                "9",
                label="9  ",
                matches=[
                    Match(wm_class="spotify"),
                    Match(wm_class="pavucontrol"),
                ],
                layout="monadtall",
            ),
            Group("0", label="0  ", matches=[], layout="monadtall"),
        ]
