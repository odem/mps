from libqtile import bar, widget
from libqtile.config import Screen
from libqtile.lazy import lazy
from helpers import normalize_window_title
from globals import (
    tm,
    ff,
    mu,
    ev,
    ge,
    gp,
    gi,
    nv,
    fm,
    zo,
    update,
    barBorderWidth,
    opacityBar,
    marginBar,
)
from colors import (
    fontWhite,
    fontYellow,
    fontBlack,
    lightRed,
    lightBlue,
    darkBlue,
    darkGray,
    barColor,
    barBorderColor,
)

icons_static = {
    "firefox": "/usr/share/icons/hicolor/128x128/apps/firefox-esr.png",
    "kitty": "/usr/share/icons/hicolor/256x256/apps/kitty.png",
    "gedit": "/usr/share/icons/gnome/256x256/apps/accessories-text-editor.png",
    "nvim": "/usr/share/icons/hicolor/128x128/apps/nvim.png",
    "thunar": "/usr/share/icons/hicolor/128x128/apps/org.xfce.thunar.png",
    "mumble": "/usr/share/icons/hicolor/scalable/apps/mumble.svg",
    "gimp": "/usr/share/icons/hicolor/256x256/apps/gimp.png",
    "evince": "/usr/share/icons/hicolor/scalable/apps/org.gnome.Evince.svg",
    "gparted": "/usr/share/icons/hicolor/scalable/apps/gparted.svg",
    "zoom": "/usr/share/pixmaps/application-x-zoom.png",
}

FONTSIZE = 20
FONTSIZE_SMALL = 20
BAR_HEIGHT = 30
SECOND_SCREEN = False


###############################################################################
# Widgets
###############################################################################
def create_widget_groupbox():
    return widget.GroupBox(
        hide_unused=False,
        disable_drag=True,
        rounded=False,
        active=fontWhite,
        inactive=fontYellow,
        urgent_text=fontBlack,
        urgent_border=lightRed,
        urgent_alert_method="block",
        font="JetBrainsMono Nerd Font",
        fontsize=FONTSIZE,
        highlight_method="line",
        highlight_color=lightBlue,
        this_current_screen_border=darkBlue,
        other_current_screen_border=darkBlue,
        padding=1,
    )


def create_widget_updater():
    return widget.CheckUpdates(
        distro="Debian",
        markup=True,
        colour_have_updates="ff0000",
        colour_no_updates="00ff00",
        display_format="({updates})",
        no_update_string="(0)",
        execute=f"{tm} --title Update --hold {update}",
    )


def create_widget_clock():
    return widget.Clock(
        font="JetBrainsMono Nerd Font",
        fontsize=FONTSIZE_SMALL,
        mouse_callbacks={
            "Button1": lazy.spawn("gsimplecal"),
        },
        format="%Y-%m-%d %a %H:%M:%S",
    )


def create_widget_battery():
    return widget.Battery(
        notify_below=0.2,
        low_percentage=0.1,
        low_foreground="#FF0000",
        low_background="#FFFFFF",
        foreground="#FFFFFF",
        charge_char="⚡",
        discharge_char="",
        full_char="",
        empty_char="💀",
        unknown_char="❓",
        not_charging_char="",
        fontsize=FONTSIZE_SMALL,
        scale=1,
        padding=0,
        battery=0,
        background="#175229",
        update_interval=1,
        show_short_text=True,
        format="{char} {percent:2.0%} {watt:.2f} W",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "kitty bash -c 'upower -i $(upower -e | grep BAT) | grep --color=never -E \"state|to\\ full|to\\ empty|percentage\" ; sleep 2'"
            ),
        },
    )


###############################################################################
# Widget boxes
###############################################################################
# def create_widgetbox_graphs():
#     return widget.WidgetBox(
#         text_open="[g]",
#         text_closed="[G]",
#         close_button_location="right",
#         widgets=[
#             widget.CPU(format="CPU:{load_percent}%"),
#             widget.CPUGraph(type="line", line_width=1),
#             widget.DF(
#                 visible_on_warn=False,
#                 format="Disk {p}: {uf}{m}/{s}{m}",
#             ),
#             widget.HDDBusyGraph(path="/", type="line", line_width=1),
#             widget.SwapGraph(type="line", line_width=1),
#             widget.Memory(
#                 measure_mem="M",
#                 format="RAM: {MemUsed:.0f}{ms}/{MemTotal:.0f}{ms}",
#             ),
#             widget.MemoryGraph(type="line", line_width=1),
#         ],
#     )


def create_widgetbox_buttons():
    return widget.WidgetBox(
        text_open="",
        text_closed="",
        start_opened=True,
        close_button_location="right",
        widgets=[
            widget.Spacer(),
            widget.Sep(padding=10, linewidth=5, size_percent=50),
            widget.Image(
                scale=True,
                filename=icons_static["firefox"],
                mouse_callbacks={
                    "Button1": lazy.spawn(ff),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["kitty"],
                mouse_callbacks={
                    "Button1": lazy.spawn(tm),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["thunar"],
                mouse_callbacks={
                    "Button1": lazy.spawn(fm),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["nvim"],
                mouse_callbacks={
                    "Button1": lazy.spawn(nv),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["gedit"],
                mouse_callbacks={
                    "Button1": lazy.spawn(ge),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["evince"],
                mouse_callbacks={
                    "Button1": lazy.spawn(ev),
                },
            ),
            widget.Image(
                scale=True,
                filename=icons_static["gimp"],
                mouse_callbacks={
                    "Button1": lazy.spawn(gi),
                },
            ),
            widget.Sep(padding=10, linewidth=5, size_percent=50),
        ],
    )


def create_widgetbox_clipboard():
    return widget.WidgetBox(
        text_open="[c]",
        text_closed="[C]",
        close_button_location="right",
        widgets=[widget.Clipboard(timeout=0)],
    )


def create_widgetbox_net():
    return widget.WidgetBox(
        text_open="[n]",
        text_closed="[N]",
        start_opened=False,
        close_button_location="right",
        widgets=[
            widget.Net(),
            widget.ThermalZone(),
        ],
    )


###############################################################################
# Top bar
###############################################################################
def create_topbar():
    return [
        widget.Sep(),
        widget.Spacer(),
        widget.WindowName(width=bar.CALCULATED),
        widget.Spacer(),
        widget.Sep(),
    ]


###############################################################################
# Screens
###############################################################################
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=FONTSIZE,
    padding=7,
)
extension_defaults = widget_defaults.copy()


class MpsScreens(object):
    def init_screens(self):
        screenlist = [
            # Primary Screen
            Screen(
                top=bar.Bar(
                    create_topbar(),
                    BAR_HEIGHT,
                    border_color=barBorderColor,
                    border_width=barBorderWidth,
                    background=barColor,
                    margin=marginBar,
                    opacity=opacityBar,
                ),
                bottom=bar.Bar(
                    [
                        widget.CurrentLayoutIcon(
                            scale=1, fontsize=FONTSIZE, background=darkGray
                        ),
                        widget.WindowCount(),
                        create_widget_groupbox(),
                        widget.Sep(),
                        widget.Prompt(prompt="Spawn: "),
                        create_widgetbox_buttons(),
                        widget.Spacer(),
                        widget.Sep(),
                        create_widgetbox_clipboard(),
                        create_widgetbox_net(),
                        widget.Sep(),
                        widget.Systray(),
                        create_widget_battery(),
                        widget.Sep(),
                        create_widget_updater(),
                        create_widget_clock(),
                    ],
                    BAR_HEIGHT,
                    border_color=barBorderColor,
                    border_width=barBorderWidth,
                    background=barColor,
                    margin=marginBar,
                    opacity=opacityBar,
                ),
            ),
        ]
        if SECOND_SCREEN:
            screenlist.append(
                # Secondary Screen
                Screen(
                    top=bar.Bar(
                        create_topbar(),
                        BAR_HEIGHT,
                        border_color=barBorderColor,
                        border_width=barBorderWidth,
                        background=barColor,
                        margin=marginBar,
                        opacity=opacityBar,
                    ),
                    bottom=bar.Bar(
                        [
                            widget.CurrentLayoutIcon(
                                scale=1, fontsize=FONTSIZE, background=darkGray
                            ),
                            widget.WindowCount(),
                            create_widget_groupbox(),
                            widget.Sep(),
                            create_widgetbox_buttons(),
                            widget.Spacer(),
                            widget.Sep(),
                            create_widgetbox_clipboard(),
                            create_widgetbox_net(),
                            widget.Sep(),
                            create_widget_updater(),
                            create_widget_clock(),
                        ],
                        BAR_HEIGHT,
                        border_color=barBorderColor,
                        border_width=barBorderWidth,
                        background=barColor,
                        margin=marginBar,
                        opacity=opacityBar,
                    ),
                ),
            )
        return screenlist
