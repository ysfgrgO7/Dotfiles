# Imports
import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Apps
mod = "mod4"
terminal = "st"
browser = "brave"
menu = "dmenu_run -c -l 20 -g 2 -p Run: "

# Colors
bg = "#1E1D2F"
blue = "#96CDFB"
cyan = "#89DCEB"
fg = "#d9e0ee"
gray = "#6E6C7E"
magenta = "#F5C2E7"
red = "#F28FAD"
yellow = "#FAE3B0"

# Keys
keys = [
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "w", lazy.spawn(browser)),
    Key([mod], "d", lazy.spawn(menu)),
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

# Groups
groups = [Group(i) for i in ["", "", "", "", ""]]
group_hotkeys = "12345"
for i, k in zip(groups, group_hotkeys):
    keys.extend(
        [
            Key(
                [mod],
                k,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                k,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

# Layouts
layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": blue,
    "border_normal": bg,
}
layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Max(),
    layout.Floating(
        border_focus=gray,
        border_normal=bg,
        border_width=4,
    ),
    layout.Bsp(
        border_focus=gray,
        border_normal=bg,
        border_width=4,
    ),
    layout.Stack(num_stacks=2),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Bold",
    fontsize=15,
    padding=9,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    text="  ",
                    background=bg,
                    foreground=fg,
                    padding=0,
                    fontsize=20,
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.GroupBox(
                    fontsize=18,
                    active=cyan,
                    inactive=gray,
                    foreground=cyan,
                    rounded=False,
                    borderwidth=2,
                    margin=4,
                    highlight_method="line",
                    highlight_color=bg,
                    other_screen_border=gray,
                    other_current_screen_border=cyan,
                    this_current_screen_border=cyan,
                    this_screen_border=gray,
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.CurrentLayout(
                    background=bg,
                    foreground=fg,
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.WindowName(foreground=fg),
                widget.Spacer(length=100),
                # # # #
                widget.Systray(icon_size=15),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.Battery(
                    foreground=cyan,
                    low_foreground=red,
                    low_percentage=0.3,
                    format="{char} {percent:2.0%}",
                    charge_char="",
                    discharge_char="",
                    full_char="",
                    unknown_char="",
                    empty_char="",
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.TextBox(
                    text=" ",
                    background=bg,
                    foreground=red,
                    padding=0,
                    fontsize=17,
                ),
                widget.ThermalZone(
                    foreground=fg,
                    background=bg,
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.TextBox(
                    text="  ",
                    background=bg,
                    foreground=yellow,
                    padding=0,
                    fontsize=17,
                ),
                widget.PulseVolume(
                    foreground=fg,
                    background=bg,
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.TextBox(
                    text="  ",
                    background=bg,
                    foreground=blue,
                    padding=0,
                    fontsize=17,
                ),
                widget.Clock(
                    background=bg,
                    foreground=fg,
                    format="%b %d - %I:%M%p",
                ),
                widget.TextBox(
                    text="|",
                    background=bg,
                    foreground=gray,
                    padding=0,
                    fontsize=17,
                ),
                widget.QuickExit(
                    background=bg,
                    foreground=red,
                    default_text=" ",
                ),
            ],
            30,
            background=bg,
            opacity=20,
            margin=[10, 10, 5, 10],
        ),
    ),
]

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

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=cyan,
    border_normal=bg,
    border_width=2,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


wmname = "LG3D"
