import os
import socket
import subprocess
from libqtile import layout, bar, widget, hook
from libqtile.config import Drag, Group, Key, Match, Screen
from libqtile.command import lazy


mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser("~")
terminal = "Alacritty"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


keys = [
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    # Super + Shift
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    # Qtile layout
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
    # Change focus
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    # Resize up, down, left, right
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # FLIP LAYOUT FOR BSP
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    # MOVE WINDOWS UP OR DOWN BSP LAYOUT Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
]


def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


keys.extend(
    [
        # MOVE WINDOW TO NEXT SCREEN
        Key(
            [mod, "shift"],
            "Right",
            lazy.function(window_to_next_screen, switch_screen=True),
        ),
        Key(
            [mod, "shift"],
            "Left",
            lazy.function(window_to_previous_screen, switch_screen=True),
        ),
    ]
)

groups = []
group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
]
# group_labels = ["", "", "", "", "", "", "", "", "🛌", "🔁",]
group_labels = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
]

group_layouts = [
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
]
# group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod], "Tab", lazy.screen.next_group()),
            Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
            Key(["mod1"], "Tab", lazy.screen.next_group()),
            Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
            #     Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
        ]
    )


def init_layout_theme():
    return {
        "margin": 0,
        "border_width": 2,
        "border_focus": "#4B244B",
        "border_normal": "#2C242C",
    }


layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Floating(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Max(**layout_theme),
]


# COLORS FOR THE BAR
# Theme name : ArcoLinux Crimson
def init_colors():
    return [
        ["#4a4a46", "#4a4a46"],  # color 0
        ["#4a4a46", "#4a4a46"],  # color 1
        ["#c0c5ce", "#c0c5ce"],  # color 2
        ["#d33682", "#d33682"],  # color 3
        ["#cf3e3e", "#cf3e3e"],  # color 4
        ["#fdf6e3", "#fdf6e3"],  # color 5
        ["#d42121", "#d42121"],  # color 6
        ["#62FF00", "#62FF00"],  # color 7
        ["#cf3e3e", "#cf3e3e"],  # color 8
        ["#eb9b9b", "#eb9b9b"],  # color 9
    ]


colors = init_colors()
colors[8] = colors[5]
colors[6] = ["#ebbcba", "#ebbcba"]
colors[1] = ["#191724", "#191724"]
colors[0] = ["#191724", "#191724"]

# WIDGETS FOR THE BAR


def init_widgets_defaults():
    return dict(font="Noto Sans", fontsize=12, padding=2, background=colors[1])


widget_defaults = init_widgets_defaults()

icon_font = "Hack Nerd Font"
icon_size = 15
text_font = "Hack Nerd Font"
text_size = 13


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.Sep(
            linewidth=0, padding=6, foreground=colors[2], background=colors[0]
        ),
        widget.GroupBox(
            font=text_font,
            fontsize=text_size,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colors[6],
            inactive=colors[8],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
            foreground=colors[2],
            background=colors[0],
            hide_unused="True",
        ),
        widget.Sep(
            linewidth=1, padding=10, foreground=colors[8], background=colors[1]
        ),
        # widget.CurrentLayout(
        #     font=text_font,
        #     fontsize=text_size,
        #     foreground=colors[6],
        #     background=colors[1],
        # ),
        # widget.Sep(
        #     linewidth=1, padding=10, foreground=colors[8], background=colors[1]
        # ),
        widget.WindowName(
            font=text_font,
            fontsize=text_size,
            foreground=colors[6],
            background=colors[1],
        ),
        # # battery option 2  from Qtile
        # widget.Sep(
        #          linewidth = 1,
        #          padding = 10,
        #          foreground = colors[2],
        #          background = colors[1]
        #          ),
        # widget.Battery(
        #          font="Noto Sans",
        #          update_interval = 10,
        #          fontsize = 12,
        #          foreground = colors[5],
        #          background = colors[1],
        #          ),
        widget.Systray(background=colors[1], icon_size=20, padding=0),
        widget.TextBox(
            font=icon_font,
            fontsize=icon_size,
            text=" 👻",
            foreground=colors[8],
            background=colors[1],
            padding=0,
        ),
        widget.CheckUpdates(
            font=text_font,
            fontsize=text_size,
            update_interval=1800,
            distro="Arch_checkupdates",
            display_format=" {updates}",
            foreground=colors[6],
            background=colors[1],
            colour_have_updates=colors[6],
            colour_no_updates=colors[6],
        ),
        widget.TextBox(
            font=icon_font,
            fontsize=icon_size,
            text="  ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
        ),
        widget.Memory(
            font=text_font,
            # format="{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}",
            format="{MemUsed: .0f}{mm}",
            measure_mem="G",
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
        ),
        widget.TextBox(
            font=icon_font,
            text="  ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
            fontsize=icon_size,
        ),
        widget.ThermalSensor(
            font=text_font,
            tag_sensor="Package id 0",
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
        ),
        widget.TextBox(
            font=icon_font,
            text="  ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
            fontsize=icon_size,
        ),
        widget.CPU(
            font=text_font,
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
            format="{load_percent}%",
        ),
        widget.TextBox(
            font=icon_font,
            text="  ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
            fontsize=icon_size,
        ),
        widget.Volume(
            font=text_font,
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
        ),
        # widget.TextBox(
        #         font="FontAwesome",
        #         text="  ",
        #         foreground=colors[8],
        #         background=colors[1],
        #         padding = 0,
        #         fontsize=16
        #         ),
        # widget.KeyboardLayout(
        #         font="Noto Sans Bold",
        #         foreground=colors[6],
        #         background=colors[1],
        #         fontsize=15,
        #         configured_keyboards=["us", "bg"],
        #         mouse_callback={'Button1': lambda : lazy.widget["keyboardlayout"].next_keyboard()},
        # ),
        widget.TextBox(
            font=icon_font,
            text=" 󰸘 ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
            fontsize=icon_size,
        ),
        widget.Clock(
            font=text_font,
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
            format="%a, %b %d",
        ),
        widget.TextBox(
            font=icon_font,
            text="  ",
            foreground=colors[8],
            background=colors[1],
            padding=0,
            fontsize=icon_size,
        ),
        widget.Clock(
            font=text_font,
            foreground=colors[6],
            background=colors[1],
            fontsize=text_size,
            format="%H:%M",
        ),
    ]
    return widgets_list


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=0.8)
        ),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=0.8)
        ),
    ]


screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN

#########################################################
################ assgin apps to groups ##################
#########################################################
# @hook.subscribe.client_new
# def assign_app_group(client):
#     d = {}
#     #####################################################################################
#     ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
#     #####################################################################################
#     d[group_names[0]] = ["Navigator", "Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
#               "navigator", "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser", ]
#     d[group_names[1]] = [ "Atom", "Subl", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
#                "atom", "subl", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord", ]
#     d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh",
#               "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
#     d[group_names[3]] = ["Gimp", "gimp" ]
#     d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld" ]
#     d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv" ]
#     d[group_names[6]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
#               "virtualbox manager", "virtualbox machine", "vmplayer", ]
#     d[group_names[7]] = ["Thunar", "Nemo", "Caja", "Nautilus", "org.gnome.Nautilus", "Pcmanfm", "Pcmanfm-qt",
#               "thunar", "nemo", "caja", "nautilus", "org.gnome.nautilus", "pcmanfm", "pcmanfm-qt", ]
#     d[group_names[8]] = ["Evolution", "Geary", "Mail", "Thunderbird",
#               "evolution", "geary", "mail", "thunderbird" ]
#     d[group_names[9]] = ["Spotify", "Pragha", "Clementine", "Deadbeef", "Audacious",
#               "spotify", "pragha", "clementine", "deadbeef", "audacious" ]
#     ######################################################################################
#
# wm_class = client.window.get_wm_class()[0]
#
#     for i in range(len(d)):
#         if wm_class in list(d.values())[i]:
#             group = list(d.keys())[i]
#             client.togroup(group)
#             client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME


main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Arcolinux-welcome-app.py"),
        Match(wm_class="Arcolinux-calamares-tool.py"),
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="Arandr"),
        Match(wm_class="feh"),
        Match(wm_class="Galculator"),
        Match(wm_class="archlinux-logout"),
        Match(wm_class="xfce4-terminal"),
    ],
    fullscreen_border_width=0,
    border_width=0,
)
auto_fullscreen = True

focus_on_window_activation = "focus"  # or smart

wmname = "LG3D"
