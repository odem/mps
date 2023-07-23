from libqtile.config import Key
from libqtile.command import lazy
from helpers import to_urgent, spawn_once
from globals import (
    startup,
    randomwp,
    rofipower,
    rofilaunch,
    rofiwindows,
    keepasslauncher,
    tm,
    fm,
    tb,
    ff,
    ap,
    pc,
    lu,
    st,
    nv,
    zo,
    gi,
    a,
    m,
    modctrl,
    modshift,
    mcs,
)


keys_static = [
    # Windows
    Key(m, "y", lazy.window.toggle_fullscreen(), desc="Fullscreen"),
    Key(m, "x", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key(m, "w", lazy.window.kill(), desc="Kill focused window"),
    # Spawn commands
    Key(m, "Left", lazy.layout.left(), desc="Move focus left"),
    Key(m, "Right", lazy.layout.right(), desc="Move focus right"),
    Key(m, "Down", lazy.layout.down(), desc="Move focus down"),
    Key(m, "Up", lazy.layout.up(), desc="Move focus up"),
    Key(m, "h", lazy.layout.left(), desc="Move focus to left"),
    Key(m, "l", lazy.layout.right(), desc="Move focus to right"),
    Key(m, "j", lazy.layout.down(), desc="Move focus down"),
    Key(m, "k", lazy.layout.up(), desc="Move focus up"),
    # More layout stuff.
    Key(m, "n", lazy.layout.normalize(), desc="Normalize window"),
    Key(m, "m", lazy.layout.maximize(), desc="Maximize Window"),
    Key(m, "Tab", lazy.next_layout(), desc="Next layout"),
    Key(modshift, "Tab", lazy.prev_layout(), desc="Prev layout"),
    Key(modshift, "space", lazy.layout.flip(), desc="Flip layout"),
    Key(modshift, "Return", lazy.layout.toggle_split(), desc="split"),
    # Move windows
    Key(modshift, "Left", lazy.layout.shuffle_left(), desc="Move l"),
    Key(modshift, "Right", lazy.layout.shuffle_right(), desc="Move r"),
    Key(modshift, "Down", lazy.layout.shuffle_down(), desc="Move d"),
    Key(modshift, "Up", lazy.layout.shuffle_up(), desc="Move u"),
    Key(modshift, "h", lazy.layout.shuffle_left(), desc="Move l"),
    Key(modshift, "l", lazy.layout.shuffle_right(), desc="Move r"),
    Key(modshift, "j", lazy.layout.shuffle_down(), desc="Move d"),
    Key(modshift, "k", lazy.layout.shuffle_up(), desc="Move u"),
    # Grow windows. If current window is on the edge of screen
    # and direction will be to screen edge - window would shrink.
    Key(modctrl, "Left", lazy.layout.grow_left(), desc="Grow l"),
    Key(modctrl, "Right", lazy.layout.grow_right(), desc="Growright"),
    Key(modctrl, "Down", lazy.layout.grow_down(), desc="Grow down"),
    Key(modctrl, "Up", lazy.layout.grow_up(), desc="Grow up"),
    Key(modctrl, "h", lazy.layout.grow_left(), desc="Grow left"),
    Key(modctrl, "l", lazy.layout.grow_right(), desc="Grow r"),
    Key(modctrl, "j", lazy.layout.grow_down(), desc="Grow down"),
    Key(modctrl, "k", lazy.layout.grow_up(), desc="Grow up"),
    Key(modctrl, "i", lazy.layout.grow(), desc="Grow window"),
    Key(modctrl, "o", lazy.layout.shrink(), desc="Shrink window"),
    Key(modctrl, "Next", lazy.layout.grow(), desc="Grow window"),
    Key(modctrl, "Prior", lazy.layout.shrink(), desc="Shrink window"),
    # WM stuff
    Key(modctrl, "p", to_urgent(), desc="Test"),
    Key(modctrl, "r", lazy.reload_config(), desc="Reload config"),
    Key(modctrl, "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(modctrl, "e", lazy.restart(), desc="Shutdown Qtile"),
    Key(modctrl, "a", lazy.spawn(startup), desc="autostart"),
    Key(modctrl, "Delete", lazy.spawn(rofipower), desc="Powermenu"),
    Key(m, "d", lazy.spawncmd(), desc="autostart"),
    # Move between groups
    Key(a, "Left", lazy.screen.prev_group(), desc="Move prev"),
    Key(a, "Right", lazy.screen.next_group(), desc="Move next group"),
    Key(a, "space", lazy.screen.toggle_group(), desc="Toggle last "),
    # Switch between windows
    Key(m, "Prior", lazy.group.prev_window(), desc="Focus prev"),
    Key(m, "Next", lazy.group.next_window(), desc="Focus next"),
    # Applications
    Key(a, "Tab", lazy.spawn(rofiwindows), desc="Launcher widget"),
    Key(m, "p", lazy.spawn(keepasslauncher), desc="Keepass"),
    Key(m, "t", lazy.spawn(randomwp), desc="Randomize wallpaper"),
    Key(m, "v", lazy.spawn(nv), desc="Randomize wallpaper"),
    Key(m, "Return", lazy.spawn(tm), desc="Launch terminal"),
    Key(m, "space", lazy.spawn(rofilaunch), desc="Start rofi"),
    # Applications + Movement
    Key(a, "F1", spawn_once(ff), lazy.group["3"].toscreen(), desc="Browser"),
    Key(a, "F2", spawn_once(tb), lazy.group["7"].toscreen(), desc="Mail"),
    Key(a, "F3", spawn_once(fm), lazy.group["2"].toscreen(), desc="Files"),
    Key(a, "F4", spawn_once(pc), lazy.group["9"].toscreen(), desc="Sound"),
    Key(a, "F5", spawn_once(lu), lazy.group["8"].toscreen(), desc="Lutris"),
    Key(a, "F6", spawn_once(st), lazy.group["8"].toscreen(), desc="Steam"),
    Key(a, "F7", spawn_once(ap), lazy.group["9"].toscreen(), desc="Music"),
    Key(a, "F8", spawn_once(gi), lazy.group["4"].toscreen(), desc="Music"),
    Key(a, "F9", spawn_once(zo), lazy.group["7"].toscreen(), desc="Music"),
]


class MpsKeybinds(object):
    def init_keybinds(self, groups):
        keys = keys_static
        for group in groups:
            keys.append(Key(m, group.name, lazy.group[group.name].toscreen()))
            keys.append(
                Key(
                    modshift,
                    group.name,
                    lazy.window.togroup(group.name, switch_group=False),
                )
            )
            keys.append(
                Key(
                    mcs,
                    group.name,
                    lazy.window.togroup(group.name, switch_group=True),
                )
            )
        return keys
