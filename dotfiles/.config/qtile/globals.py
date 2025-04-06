import os

###############################################################################
# Global options
###############################################################################
auto_fullscreen = False
focus_on_window_activation = "smart"
cursor_wrap = True
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True

###############################################################################
# mod keys
###############################################################################
alt = "mod1"
mod = "mod4"
a = [alt]
m = [mod]
modctrl = [mod, "control"]
modshift = [mod, "shift"]
mcs = [mod, "control", "shift"]
###############################################################################
# Variables and default commandlines
###############################################################################
home = os.path.expanduser("~")
terminal = "kitty"
ap = "spotify"
ev = "evince"
ff = "firefox-esr"
fm = "thunar"
ge = "gedit"
gp = f"{home}/mps/snippets/launch_gparted.bash"
lu = "lutris"
nv = f"{terminal} nvim"
pc = "pavucontrol"
st = "steam"
tb = "thunderbird"
tm = f"{home}/mps/snippets/launch_kitty.bash"
mux = f"{terminal} {home}/mps/snippets/launch_tmux.bash"

rofilaunch = f"{home}/mps/snippets/rofi-boot-launcher.sh"
rofiwindows = "rofi -show window"
rofipower = f"{home}/mps/snippets/rofi-boot-powermenu.sh"
screenshot = "gnome-screenshot -i"
keepasslauncher = f"keepass2 {home}/mps/secrets/Database.kdbx"
randomwp = f"{home}/mps/snippets/randomize_wp.bash"
startup = f"{home}/mps/snippets/autostart.sh"
cleanup = f"{home}/mps/snippets/autostart_clean.sh"
update = f"{home}/mps/snippets/launch_updates.bash"
opacityBar = 1
barBorderWidth = 2
resizeAmount = 30
marginBar = [1, 4, 1, 4]
widthBorder = 1
gapsWindow = 3
wallpapers = {
    "1": f"{home}/.config/images/wallpaper/wormhole.jpg",
    "2": f"{home}/.config/images/wallpaper/moon.jpg",
    "3": f"{home}/.config/images/wallpaper/mountains.jpg",
    "4": f"{home}/.config/images/wallpaper/zwielicht.jpg",
    "5": f"{home}/.config/images/wallpaper/mainframe.jpg",
    "6": f"{home}/.config/images/wallpaper/backyard.jpg",
    "7": f"{home}/.config/images/wallpaper/mobile.jpg",
    "8": f"{home}/.config/images/wallpaper/tarkov.jpg",
    "9": f"{home}/.config/images/wallpaper/guitar.jpg",
    "0": f"{home}/.config/images/wallpaper/vorschlag.jpg",
}
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=14,
    padding=7,
)
extension_defaults = widget_defaults.copy()

spotifynext = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
spotifyprev = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
spotifyplay = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
spotifystop = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop"
