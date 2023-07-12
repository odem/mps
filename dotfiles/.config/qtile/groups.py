from libqtile.config import Group, Match


cls = {
    "1": [],
    "2": ["thunar", "Thunar"],
    "3": ["Firefox-esr"],
    "4": [""],
    "5": ["Gnome-system-monitor"],
    "6": [],
    "7": ["thunderbird-default", "mumble", "zoom"],
    "8": ["lutris", "steam", "steamwebhelper"],
    "9": ["spotify", "pavucontrol"],
    "0": ["Nirvana"],
}


class MpsGroups(object):
    def init_groups(self):
        return [
            Group("1", label="1  ", matches=cls["1"], layout="monadtall"),
            Group("2", label="2  ", matches=cls["2"], layout="treetab"),
            Group("3", label="3  ", matches=cls["3"], layout="max"),
            Group("4", label="4  ", matches=cls["4"], layout="columns"),
            Group("5", label="5  ", matches=cls["5"], layout="matrix"),
            Group("6", label="6  ", matches=cls["6"], layout="max"),
            Group("7", label="7  ", matches=cls["7"], layout="treetab"),
            Group("8", label="8  ", matches=cls["8"], layout="max"),
            Group("9", label="9  ", matches=cls["9"], layout="max"),
            Group("0", label="0  ", matches=cls["0"], layout="monadtall"),
        ]
