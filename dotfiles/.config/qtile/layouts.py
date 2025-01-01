from libqtile.layout.columns import Columns
from libqtile.layout.max import Max
from libqtile.layout.xmonad import MonadTall, MonadWide
from libqtile.layout.tree import TreeTab
from libqtile.layout.matrix import Matrix

from globals import widthBorder, gapsWindow
from colors import layoutColorBlack, layoutColorGreen, layoutColorLightRed


class MpsLayouts(object):
    def init_layouts(self):
        return [
            # Columns(
            #     border_focus_stack=layoutColorGreen,
            #     border_width=widthBorder,
            #     margin=gapsWindow,
            #     border_focus=layoutColorLightRed,
            #     border_normal=layoutColorBlack,
            # ),
            Max(
                border_width=widthBorder,
                margin=gapsWindow,
                border_focus=layoutColorLightRed,
                border_normal=layoutColorBlack,
            ),
            Matrix(
                border_width=widthBorder,
                margin=gapsWindow,
                border_focus=layoutColorLightRed,
                border_normal=layoutColorBlack,
            ),
            MonadTall(
                border_width=widthBorder,
                margin=gapsWindow,
                border_focus=layoutColorLightRed,
                border_normal=layoutColorBlack,
            ),
            MonadWide(
                border_width=widthBorder,
                margin=gapsWindow,
                border_focus=layoutColorLightRed,
                border_normal=layoutColorBlack,
            ),
            TreeTab(border_width=widthBorder),
        ]
