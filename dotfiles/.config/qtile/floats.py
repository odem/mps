from libqtile.config import Match
from libqtile.layout.floating import Floating


class MpsFloats(object):
    def init_floats(self):
        return Floating(
            float_rules=[
                # Run the utility of `xprop`
                # to see the wm class and name of an X client.
                *Floating.default_float_rules,
                Match(wm_class="ssh-askpass"),  # ssh-askpass
                Match(wm_class="Tilda"),  # tilda
                Match(wm_class="Rofi"),  # Rofi
                Match(wm_class="Pavucontrol"),  # pavu
                Match(wm_class="KeePass2"),  # keepass
            ]
        )
