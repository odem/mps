# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

###############################################################################
# Deault imports
###############################################################################
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import hook
import subprocess
import os

###############################################################################
# mod keys
###############################################################################
alt = "mod1"
mod = "mod4"
###############################################################################
# Variables and default commandlines
###############################################################################
terminal = "kitty"
home = os.path.expanduser('~')
autostart_init = f"{home}/mps/snippets/autostart.sh"
rofilaunch = f"{home}/mps/snippets/rofi-boot-launcher.sh"
rofipower = f"{home}/mps/snippets/rofi-boot-powermenu.sh"
sysmon = "gnome-system-monitor"


###############################################################################
# Autostart
###############################################################################
@hook.subscribe.startup_once
def autostart():
    subprocess.call([autostart_init])


###############################################################################
# Colors
###############################################################################
lightRed = "984040"
lightGreen = "409840"
lightBlue = "464098"
fontBlack = "000000"
fontWhite = "ffffff"
fontRed = "ff0000"
fontGreen = "00ff00"
fontYellow = "#ffff00"
# Bar Colors
lightGray = "#474747ff"
mediumGray = "#404040ff"
darkGray = "#202020ff"
barColor = [
    darkGray,
    '#303030ff',
    mediumGray,
    mediumGray,
    lightGray,
    mediumGray,
    mediumGray,
    '#303030ff',
    darkGray,
]
borderColor = '#101010ff'
barBorderColor = [borderColor, borderColor, borderColor, borderColor]
###############################################################################
# Margin and padding
###############################################################################
marginBar = [1, 4, 1, 4]
opacityBar = 1
barBorderWidth = 2
###############################################################################
# Misc options
###############################################################################
resizeAmount = 30
###############################################################################
# Groups
###############################################################################
groups = [
    Group("1", layout="monadtall", label="1  "),
    Group(
        "2",
        layout="treetab",
        label="2  ",
        matches=[Match(wm_class=["thunar", "Gnome-system-monitor"])],
    ),
    Group(
        "3",
        layout="max",
        label="3  ",
        matches=[Match(wm_class=["Firefox-esr"])],
    ),
    Group(
        "4",
        layout="columns",
        label="4  ",
        matches=[Match(wm_class=["eclipse"])],
    ),
    Group(
        "5",
        layout="matrix",
        label="5  ",
        matches=[Match(wm_class=["TigerVNC Viewer"])],
    ),
    Group("6", layout="max", label="6  "),
    Group(
        "7",
        layout="treetab",
        label="7  ",
        matches=[Match(wm_class=["thunderbird-default", "mumble", "zoom"])],
    ),
    Group("8", layout="max", label="8  "),
    Group("9", layout="max", label="9  ", matches=[Match(wm_class=["Gmpc"])]),
]
###############################################################################
# Keys
###############################################################################
keys = [
    # Switch between windows
    Key([mod], "Prior", lazy.group.prev_window(), desc="Focus prev window"),
    Key([mod], "Next", lazy.group.next_window(), desc="Focus next window"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "Down",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        desc="Grow window left",
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        desc="Grow window right",
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
        desc="Grow window down",
    ),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key(
        [mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window left"
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window right",
    ),
    Key(
        [mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"
    ),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "i", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "o", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod, "control"], "Next", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "Prior", lazy.layout.shrink(), desc="Shrink window"),
    # More layout stuff.
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize window"),
    Key([mod], "m", lazy.layout.maximize(), desc="Maximize Window"),
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Prev layout"),
    Key([mod, "shift"], "space", lazy.layout.flip(), desc="Flip layout"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="split",
    ),
    # Quit and Reload
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"], "Delete", lazy.spawn(rofipower), desc="Powermenu"),
    # Windows
    Key([mod], "y", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "x", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # Spawn commands
    Key([mod], "d", lazy.spawn(rofilaunch), desc="Launcher widget"),
    Key([mod], "a", lazy.spawn(autostart_init), desc="Invoke autostart"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Gui tools
    Key([alt], "F1", lazy.spawn("firefox"), desc="Browser"),
    Key([alt], "F2", lazy.spawn("thunderbird"), desc="Email"),
    Key([alt], "F3", lazy.spawn("thunar"), desc="FileManager"),
    Key([alt], "F4", lazy.spawn("pavucontrol"), desc="SoundControl"),
    # Move between groups
    Key([alt], "Left", lazy.screen.prev_group(), desc="Move prev group"),
    Key([alt], "Right", lazy.screen.next_group(), desc="Move next group"),
    Key([alt], "space", lazy.screen.toggle_group(), desc="Toggle last used"),
    # Resize windows
    # Key([alt], "Up", lazy.window.resize_floating(0,-resizeAmount), desc="Shrink x"),
    # Key([alt], "Down", lazy.window.resize_floating(0,resizeAmount), desc="Grow x"),
    # Key([alt], "Left", lazy.window.resize_floating(-resizeAmount,0), desc="Shrink x"),
    # Key([alt], "Right", lazy.window.resize_floating(resizeAmount,0), desc="Grow x"),
]
###############################################################################
# Mouse
###############################################################################
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button2",
        lazy.window.set_size_floating(),
        start=lazy.window.get_position(),
    ),
    Click(
        [mod],
        "Button4",
        lazy.window.resize_floating(resizeAmount, resizeAmount),
    ),
    Click(
        [mod],
        "Button5",
        lazy.window.resize_floating(-resizeAmount, -resizeAmount),
    ),
    Click([mod], "Button3", lazy.window.bring_to_front()),
]
###############################################################################
# Group Assignments
###############################################################################
for group in groups:
    keys.extend(
        [
            Key(
                [
                    mod,
                ],
                group.name,
                lazy.group[group.name].toscreen(),
            ),
            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name, switch_group=False),
            ),
        ]
    )
###############################################################################
# Layouts
###############################################################################
widthBorder = 1
gapsWindow = 3

layouts = [
    layout.Columns(
        border_focus_stack=fontGreen,
        border_width=widthBorder,
        margin=gapsWindow,
        border_focus=lightRed,
        border_normal=fontBlack,
    ),
    layout.Max(
        border_width=widthBorder,
        margin=gapsWindow,
        border_focus=lightRed,
        border_normal=fontBlack,
    ),
    layout.Matrix(
        border_width=widthBorder,
        margin=gapsWindow,
        border_focus=lightRed,
        border_normal=fontBlack,
    ),
    layout.MonadTall(
        border_width=widthBorder,
        margin=gapsWindow,
        border_focus=lightRed,
        border_normal=fontBlack,
    ),
    layout.MonadWide(
        border_width=widthBorder,
        margin=gapsWindow,
        border_focus=lightRed,
        border_normal=fontBlack,
    ),
    layout.TreeTab(border_width=widthBorder),
]
###############################################################################
# Widgets
###############################################################################
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=14,
    padding=7,
)
extension_defaults = widget_defaults.copy()
###############################################################################
# Screens
###############################################################################


def normalizeWindowTitle(text):
    for string in [" - Chromium", " - Mozilla Firefox", "Mozilla Firefox"]:
        text = text.replace(string, "")
    return text


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(),
                widget.Spacer(),
                widget.WindowName(width=bar.CALCULATED),
                widget.Spacer(),
                widget.Sep(),
                widget.WidgetBox(
                    text_open='[n]',
                    text_closed='[N]',
                    start_opened=True,
                    close_button_location='right',
                    widgets=[
                        widget.Net(),
                    ],
                ),
            ],
            20,
            border_color=barBorderColor,
            border_width=barBorderWidth,
            background=barColor,
            margin=marginBar,
            opacity=opacityBar,
        ),
        bottom=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    scale=0.6, fontsize=8, background=darkGray
                ),
                widget.WindowCount(),
                widget.GroupBox(
                    hide_unused=True,
                    disable_drag=True,
                    rounded=False,
                    active=fontWhite,
                    inactive=fontYellow,
                    urgent_text=lightRed,
                    font='JetBrainsMono Nerd Font',
                    fontsize=14,
                    highlight_method='block',
                    # highlight_color=[lightRed],
                    urgent_alert_method='line',
                    this_current_screen_border=darkGray,
                    padding=5,
                ),
                widget.Spacer(),
                widget.WidgetBox(
                    text_open='[t]',
                    text_closed='[T]',
                    close_button_location='right',
                    widgets=[
                        widget.Sep(),
                        widget.TaskList(
                            parse_text=normalizeWindowTitle,
                            margin_x=5,
                            title_width_method='uniform',
                            padding=1,
                            margin=1,
                            markup=True,
                        ),
                    ],
                ),
                widget.WidgetBox(
                    text_open='[g]',
                    text_closed='[G]',
                    close_button_location='right',
                    widgets=[
                        widget.CPU(format='CPU:{load_percent}%'),
                        widget.CPUGraph(type='line', line_width=1),
                        widget.DF(
                            visible_on_warn=False,
                            format='Disk {p}: {uf}{m}/{s}{m}',
                        ),
                        widget.HDDBusyGraph(
                            path='/', type='line', line_width=1
                        ),
                        widget.Memory(
                            measure_mem='M',
                            format="RAM: {MemUsed:.0f}{ms}/{MemTotal:.0f}{ms}",
                        ),
                        widget.MemoryGraph(type='line', line_width=1),
                        # widget.TextBox(fmt="NET: "),
                        widget.Net(prefix='M', format='NET: {up:} {down:}'),
                        widget.NetGraph(type='line', line_width=1),
                    ],
                ),
                widget.WidgetBox(
                    text_open='[c]',
                    text_closed='[C]',
                    close_button_location='right',
                    widgets=[widget.Clipboard(timeout=0)],
                ),
                widget.CheckUpdates(
                    distro='Debian',
                    markup=True,
                    colour_have_updates='ff0000',
                    colour_no_updates='00ff00',
                    display_format='({updates})',
                    no_update_string='(0)',
                    execute='kitty --title Update --hold sudo apt update && sudo apt upgrade',
                ),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %H:%M:%S"),
            ],
            24,
            border_color=barBorderColor,
            border_width=barBorderWidth,
            background=barColor,
            margin=marginBar,
            opacity=opacityBar,
        ),
    ),
]
###############################################################################
# Floating and other optional stuff
###############################################################################
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="Tilda"),  # tilda
        Match(wm_class="Rofi"),  # tilda
        # Match(wm_class="Firefox-esr"),  # tilda
        Match(wm_class="Gmpc"),  # tilda
        Match(wm_class="Pavucontrol"),  # tilda
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"
