import os
import subprocess
from typing import List
from libqtile import hook
from libqtile.bar import Bar
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from libqtile.layout.xmonad import MonadTall
from libqtile.layout.stack import Stack
from libqtile.layout.floating import Floating
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.windowname import WindowName
from libqtile.widget.cpu import CPU
from libqtile.widget.memory import Memory
from libqtile.widget.volume import Volume
from libqtile.widget.clock import Clock
from libqtile.widget.spacer import Spacer
from libqtile.widget.textbox import TextBox
from libqtile.widget.thermal_zone import ThermalZone
from libqtile.widget.quick_exit import QuickExit
from colors import doom_one, gruvbox, nord, onedark


mod = "mod4"
Myterm = "st"

colors = onedark

keys = [
    Key([mod], "w", lazy.spawn("brave")),
    Key([mod], "Return", lazy.spawn(Myterm)),
    Key([mod], "d", lazy.spawn("dmenu_run -c -l 20 -g 2 -p Run: ")),
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "control"], "space", lazy.layout.flip()),
    Key([mod, "shift"], "space", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod, "shift"], "l", lazy.layout.grow()),
    Key([mod, "shift"], "h", lazy.layout.shrink()),
    Key([mod, "shift"], "r", lazy.reload_config()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
]

groups = [
    Group("1", label="一", layout="monadtall"),
    Group("2", label="二", layout="monadtall"),
    Group("3", label="三", layout="monadtall"),
    Group("4", label="四", layout="monadtall"),
    Group("5", label="五", layout="monadtall"),
    Group("6", label="六", layout="monadtall"),
    Group("7", label="七", layout="monadtall"),
    Group("8", label="八", layout="monadtall"),
    Group("9", label="九", layout="monadtall"),
]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown("term", "st", opacity=1.0, width=0.8, height=0.8, y=0.1),
            DropDown("ranger", "st ranger", opacity=1.0, width=0.8, height=0.8, y=0.1),
            DropDown("music", "deadbeed", opacity=1.0, width=0.8, height=0.8, y=0.1),
            DropDown("pulse", "st pulsemixer", width=0.4, x=0.3, y=0.2),
        ],
    )
)

keys.extend(
    [
        Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term")),
        Key([mod], "e", lazy.group["scratchpad"].dropdown_toggle("ranger")),
        Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("pulse")),
        Key([mod], "m", lazy.group["scratchpad"].dropdown_toggle("music")),
    ]
)

layouts = [
    Stack(
        border_normal=colors["dark-gray"],
        border_focus=colors["blue"],
        border_width=2,
        num_stacks=1,
        margin=10,
    ),
    MonadTall(
        border_normal=colors["dark-gray"],
        border_focus=colors["blue"],
        margin=10,
        border_width=2,
        single_border_width=2,
        single_margin=10,
    ),
]

floating_layout = Floating(
    border_normal=colors["dark-gray"],
    border_focus=colors["blue"],
    border_width=4,
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="pavucontrol"),
        Match(wm_class="zoom"),
        Match(wm_class="bitwarden"),
        Match(wm_class="kdenlive"),
    ],
)

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
widget_defaults = dict(
    font="jetbrainsmono nerd font",
    fontsize=13,
    padding=10,
    foreground=colors["bg"],
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=Bar(
            [
                TextBox(
                    text="  ",
                    background=colors["bg"],
                    foreground=colors["fg"],
                    padding=0,
                    fontsize=20,
                ),
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                GroupBox(
                    disable_drag=True,
                    active=colors["gray"],
                    inactive=colors["dark-gray"],
                    highlight_method="line",
                    block_highlight_text_color=colors["red"],
                    borderwidth=0,
                    highlight_color=colors["bg"],
                    background=colors["bg"],
                ),
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                CurrentLayout(
                    background=colors["bg"],
                    foreground=colors["fg"],
                ),
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                WindowName(foreground=colors["fg"]),
                Spacer(length=100),
                # # # #
                # thermal zone
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                TextBox(
                    text=" ",
                    background=colors["bg"],
                    foreground=colors["red"],
                    padding=0,
                    fontsize=17,
                ),
                ThermalZone(
                    foreground=colors["fg"],
                    background=colors["bg"],
                ),
                # volume
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                TextBox(
                    text="  ",
                    background=colors["bg"],
                    foreground=colors["yellow"],
                    padding=0,
                    fontsize=17,
                ),
                Volume(
                    foreground=colors["fg"],
                    background=colors["bg"],
                ),
                # cpu
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                TextBox(
                    text="  ",
                    background=colors["bg"],
                    foreground=colors["cyan"],
                    padding=0,
                    fontsize=17,
                ),
                CPU(
                    format="{load_percent}%",
                    background=colors["bg"],
                    foreground=colors["fg"],
                ),
                # memory
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                TextBox(
                    text="  ",
                    background=colors["bg"],
                    foreground=colors["magenta"],
                    padding=0,
                    fontsize=17,
                ),
                Memory(
                    background=colors["bg"],
                    foreground=colors["fg"],
                    format="{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}",
                    padding=1,
                ),
                # date - time
                TextBox(
                    text=" |",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                TextBox(
                    text="  ",
                    background=colors["bg"],
                    foreground=colors["blue"],
                    padding=0,
                    fontsize=17,
                ),
                Clock(
                    background=colors["bg"],
                    foreground=colors["fg"],
                    format="%b %d - %I:%M%p",
                ),
                TextBox(
                    text="|",
                    background=colors["bg"],
                    foreground=colors["gray"],
                    padding=0,
                    fontsize=17,
                ),
                QuickExit(
                    background=colors["bg"],
                    foreground=colors["red"],
                    default_text=" ",
                ),
            ],
            margin=[10, 10, 5, 10],
            background=colors["bg"],
            opacity=20,
            size=30,
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = ""
cursor_warp = False
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])
