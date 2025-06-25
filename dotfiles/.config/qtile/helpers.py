from libqtile import qtile
from libqtile.lazy import lazy
from libqtile import hook
from libqtile.log_utils import logger

from globals import wallpapers, startup
import subprocess


###############################################################################
# Custom functions
###############################################################################
@hook.subscribe.setgroup
def currentgroup_changed():
    group = str(qtile.current_group.name)
    sc = qtile.current_screen
    sc.set_wallpaper(wallpapers[group], mode="fill")


@hook.subscribe.startup_once
def autostart():
    subprocess.call([startup])


@lazy.function
def spawn_once(qtile, progname):
    cmd = f"pgrep -i {progname} || {progname} &"
    subprocess.run([cmd], shell=True)


@lazy.function
def to_urgent(qtile):
    cg = str(qtile.current_group.name)
    logger.error(dir(qtile.current_screen))
    for group in qtile.groups_map.values():
        if group == cg:
            continue
        if len([w for w in group.windows if w.urgent]) > 0:
            qtile.current_screen.set_group(group)
            return


def normalize_window_title(text):
    for string in [" - Chromium", " - Mozilla Firefox", "Mozilla Firefox"]:
        text = text.replace(string, "")
    return text
