from os import getenv
from os.path import expanduser
from libqtile import layout, bar, widget, hook
from libqtile.config import EzClick, EzDrag, Group, ScratchPad, DropDown, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from float_rules import rules as custom_float_rules
from commands import WindowCommands
from util import get_displays, bind_keys, Rofi
import widgets as custom_widget

from importlib import reload
import themes
reload(themes)
from themes import onedark as theme

# CONSTANTS
terminal = getenv("TERMINAL")
editor = getenv("EDITOR")
browser = getenv("BROWSER")
bin_dir = expanduser("~/.dotfiles/bin")
rofi_scripts_dir = expanduser("~/.dotfiles/rofi/scripts")

# KEYS
win_cmds = WindowCommands()
rofi = Rofi(rofi_scripts_dir)

keys = bind_keys(
    # Navigation
    ("M-h", lazy.layout.left(), "Move focus left"),
    ("M-j", lazy.layout.down(), "Move focus down"),
    ("M-k", lazy.layout.up(), "Move focus up"),
    ("M-l", lazy.layout.right(), "Move focus right"),

    ("M-i", lazy.next_screen(), "Focus next screen"),
    ("M-u", lazy.next_urgent(), "Focus next urgent window"),

    # Positioning
    ("M-S-h", lazy.layout.shuffle_left(), "Shuffle window left"),
    ("M-S-j", lazy.layout.shuffle_down(), "Shuffle window down"),
    ("M-S-k", lazy.layout.shuffle_up(), "Shuffle window up"),
    ("M-S-l", lazy.layout.shuffle_right(), "Shuffle window right"),
    ("M-S-i", win_cmds.to_next_screen(), "Shuffle window right"),
    ("M-S-y", win_cmds.to_empty_group(), "Shuffle window right"),

    # Windows
    ("M-f", lazy.window.toggle_floating(), "Toggle floating"),
    ("M-m", win_cmds.toggle_maximized(layout="mono"), "Toggle mono layout"),
    ("M-S-m", win_cmds.toggle_maximized(layout="max"), "Toggle max layout"),
    # ("M-S-n", win_cmds.to_inactive_group(), "Move window to first inactive group"),
    ("M-q", lazy.window.kill(), "Kill focused window"),
    ("M-<bracketleft>", lazy.window.down_opacity(), "Kill focused window"),
    ("M-<bracketright>", lazy.window.up_opacity(), "Kill focused window"),
    ("M-<equal>", lazy.window.opacity(1), "Kill focused window"),
    ("M-w", [
        ("f", lazy.window.toggle_fullscreen(), "Toggle fullscreen"),
        ("h", lazy.window.toggle_minimize(), "Toggle minimize"),
    ], ""),
    ("M-<Tab>", lazy.spawn('rofi -modi window,windowcd -show window'), "Rofi (windows)"),

    # Layouts
    ("M-g", [
        ("t", lazy.group.setlayout("tall"), "Monad tall layout"),
        ("m", lazy.group.setlayout("mid"), "Monad 3-column mid layout"),
        ("d", lazy.group.setlayout("dual"), "Dual layout"),
        ("c", lazy.group.setlayout("cols"), "Columns layout"),
    ], ""),

    ("M-C-h", [
        lazy.layout.shrink_main().when(layout=["tall", "mid"]),
        lazy.layout.grow_left().when(layout="cols"),
    ], "Grow window left"),
    ("M-C-j", [
        lazy.layout.grow().when(layout=["tall", "mid"]),
        lazy.layout.grow_down().when(layout="cols"),
    ], "Grow window down"),
    ("M-C-k", [
        lazy.layout.shrink().when(layout=["tall", "mid"]),
        lazy.layout.grow_up().when(layout="cols"),
    ], "Grow window up"),
    ("M-C-l", [
        lazy.layout.grow_main().when(layout=["tall", "mid"]),
        lazy.layout.grow_right().when(layout="cols"),
    ], "Grow window right"),

    ("M-C-m", [
        lazy.layout.maximize().when(layout=["tall", "mid"]),
    ], "Maximize window"),
    ("M-C-s", [
        lazy.layout.toggle_split().when(layout="cols")
    ], "Toggle split"),
    ("M-C-n", [
        lazy.layout.reset().when(layout=["tall", "mid"]),
        lazy.layout.normalize().when(layout="cols"),
    ], "Reset layout"),
    ("M-C-i", [
        lazy.layout.swap_column_left().when(layout="cols")
    ], "Shuffle window right"),
    ("M-C-o", [
        lazy.layout.swap_column_right().when(layout="cols")
    ], "Shuffle window right"),
    ("M-C-f", [
        lazy.layout.flip().when(layout="tall")
    ], "Shuffle window right"),

    # Applications
    ("M-<Return>", lazy.spawn(terminal), "Launch terminal"),
    ("M-e", lazy.spawn(f"{terminal} {editor}"), "Launch editor"),
    ("M-b", lazy.spawn(browser), "Launch browser"),
    ("M-S-b", lazy.spawn(f"{browser} --incognito"), "Launch browser (incognito)"),

    # Launchers
    ("M-<space>", lazy.spawn("rofi -show drun"), "Rofi (drun)"),
    ("M-S-<space>", [
        ("p", lazy.spawn(rofi.script("projects")), "Rofi (projects)"),
        ("d", lazy.spawn(rofi.script("dotfiles")), "Rofi (dotfiles)"),
        ("b", lazy.spawn(rofi.script("bookmarks")), "Rofi (bookmarks)"),
        ("e", lazy.spawn("rofimoji"), "Rofi (emoji)"),
        ("s", lazy.spawn(rofi.script("system")), "Rofi (system)"),
    ], ""),

    # Volume
    ("<XF86AudioRaiseVolume>", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"), "Increase volume"),
    ("<XF86AudioLowerVolume>", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"), "Decrease volume"),
    ("<XF86AudioMute>", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), "Mute volume"),

    # Media
    ("<XF86AudioPlay>", lazy.spawn(f"{bin_dir}/spotifyctl play-pause"), "Play/Pause media"),
    ("<XF86AudioPrev>", lazy.spawn(f"{bin_dir}/spotifyctl prev"), "Previous media"),
    ("<XF86AudioNext>", lazy.spawn(f"{bin_dir}/spotifyctl next"), "Next media"),

    # Misc
    ("<Print>", lazy.spawn("flameshot gui"), "Launch flameshot"),
    ("S-<Print>", lazy.spawn("flameshot screen --clipboard"), "Launch flameshot"),
    ("M-n", lazy.spawn("dunstctl history-pop"), "Pop last notification"),
    ("M-S-n", lazy.spawn("dunstctl close-all"), "Close all notifications"),
    # ("M-C-n", lazy.spawn("dunstctl set-paused toggle"), "Toggle notifications"),

    # Qtile
    ("M-C-r", lazy.restart(), "Restart qtile"),
)

# GROUPS
groups = [Group(i) for i in "12347890"]

for g in groups:
    keys += bind_keys(
        (f"M-{g.name}", lazy.group[g.name].toscreen(toggle=False), f"Switch to group {g.name}"),
        (f"M-S-{g.name}", lazy.window.togroup(g.name, switch_group=True), f"Move focused window to group {g.name}"),
        (f"M-C-{g.name}", lazy.window.togroup(g.name, switch_group=False), f"Move focused window to group {g.name}"),
    )

groups += [
    ScratchPad("scratchpad", [
        DropDown("terminal", terminal, x=0.3, y=0.2, width=0.4, height=0.6, opacity=1.0),
        DropDown("qalc", "qalculate-gtk", x=0.4, y=0.3, width=0.2, height=0.1, opacity=1.0),
        DropDown("notes", f"{terminal} {bin_dir}/scratchpad", x=0.3, y=0.2, width=0.4, height=0.6, opacity=1.0),
    ]),
]

scratchpad = lazy.group["scratchpad"]
keys += bind_keys(
    ("M-S-<Return>", scratchpad.dropdown_toggle("terminal"), ""),
    ("M-c", scratchpad.dropdown_toggle("qalc"), ""),
    ("M-v", scratchpad.dropdown_toggle("notes"), ""),
)

# MOUSE
mouse = [
    EzDrag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    EzDrag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    EzClick("M-S-1", lazy.window.disable_floating()),
    EzClick("M-C-1", lazy.window.bring_to_front()),
]

# LAYOUTS
layout_defaults = dict(
    margin=5,
    border_width=2,
    border_normal=theme.windows["border"],
    border_focus=theme.windows["border_focus"],
    border_on_single=True,
    border_normal_stack=theme.windows["border"],
    border_focus_stack=theme.windows["border_focus"],
    split=False,
)
margin_single_window = [5, 290, 5, 290]

layouts = [
    layout.MonadTall(
        **layout_defaults,
        name="tall",
        new_client_position="top",
        single_margin=margin_single_window,
    ),
    layout.MonadThreeCol(
        **layout_defaults,
        name="mid",
        single_margin=margin_single_window,
    ),
    layout.Columns(
        **layout_defaults,
        name="dual",
        num_columns=2,
        margin_on_single=margin_single_window,
    ),
    layout.Columns(
        **(layout_defaults | dict(
            border_normal_stack=theme.windows["border_stack"],
            border_focus_stack=theme.windows["border_stack_focus"],
            split=True,
        )),
        name="cols",
        num_columns=3,
    ),
    layout.Max(
        **(layout_defaults | dict(margin=margin_single_window)),
        name="mono",
    ),
    layout.Max(
        **layout_defaults,
        name="max",
    ),
]

floating_layout = layout.Floating(
    border_focus=theme.windows["border_focus"],
    float_rules=[
        *layout.Floating.default_float_rules,
        *custom_float_rules,
    ]
)

# WIDGETS
widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize=16,
    foreground=theme.widgets["value_fg"],
    background=theme.widgets["bg"],
)
widget_short_update_interval = 5
widget_long_update_interval = 600

sep_defaults = dict(
    foreground=theme.sep["fg"],
    padding=5,
    size_percent=70,
)


def with_glyph(glyph, w):
    w.padding = 0
    return [
        widget.Spacer(
            length=5,
        ),
        widget.TextBox(
            font="Material Icons",
            foreground=theme.widgets["label_fg"],
            text=glyph,
            padding=0,
        ),
        widget.Spacer(
            length=5,
        ),
        w,
        widget.Spacer(
            length=5,
        )
    ]


def widgets_left():
    return [
        widget.GroupBox(
            rounded=False,
            use_mouse_wheel=False,
            disable_drag=True,
            foreground=theme.groups["fg"],
            background=theme.groups["bg"],
            highlight_method="line",
            highlight_color=theme.groups["bg"],
            active=theme.groups["active_fg"],
            inactive=theme.groups["inactive_fg"],
            # this_current_screen_border=theme.groups["current_screen_bg"],
            this_current_screen_border="#d55fde",
            this_screen_border=theme.groups["current_screen_bg"],
            other_screen_border=theme.groups["other_screens_bg"],
            other_current_screen_border=theme.groups["other_screens_bg"],
            urgent_alert_method="text",
            urgent_text=theme.groups['urgent_fg'],
            margin_y=5,
        ),
        widget.Sep(**sep_defaults),
        widget.CurrentLayout(
            foreground=theme.layout_indicator["fg"],
            background=theme.layout_indicator["bg"],
        ),
        widget.Sep(**sep_defaults),
        widget.TaskList(
            highlight_method='block',
            title_width_method='uniform',
            # borderwidth=2,
            rounded=False,
            spacing=5,
            # margin=0,
            # padding_x=5,
            max_title_width=350,
            txt_minimized='[H] ',
            txt_floating='',
            foreground=theme.windows['title_fg'],
            border=theme.windows['border'],
            unfocused_border='#31353f',
            urgent_border=theme.windows['border_urgent'],
        ),
    ]


def widgets_right():
    return [
        widget.Sep(**sep_defaults),
        *with_glyph(
            "\ue9e4",
            widget.CPU(
                update_interval=widget_short_update_interval,
                format="{load_percent:.0f}%",
            ),
        ),
        *with_glyph(
            "\ue322",
            widget.Memory(
                update_interval=widget_short_update_interval,
                format="{MemPercent:.0f}%",
            ),
        ),
        *with_glyph(
            "\ue623",
            widget.DF(
                visible_on_warn=False,
                format="{uf}{m}",
            ),
        ),
        *with_glyph(
            "\ue1ff",
            custom_widget.SensorTemp(
                update_interval=widget_short_update_interval,
                sensor="coretemp",
                label="Package id 0",
                warning_threshold=80,
                critical_threshold=95,
            ),
        ),
        *with_glyph(
            "\ue332",
            custom_widget.SensorFan(
                update_interval=widget_short_update_interval,
                sensor="dell_smm",
                label="",
                warning_threshold=5000,
                critical_threshold=6000,
            ),
        ),
        *with_glyph(
            "\ue63e",
            widget.Wlan(
                update_interval=widget_short_update_interval,
                interface="wlp2s0",
                format="{percent:2.0%}",
                disconnected_message="off",
            ),
        ),
        *with_glyph(
            "\ue0da",
            custom_widget.VPN(
                interface="vpn0",
                update_interval=widget_short_update_interval,
            ),
        ),
        *with_glyph(
            "\ue3e7",
            custom_widget.PowerManagementStatus(
                update_interval=widget_short_update_interval,
                off_foreground="#f44747",
            ),
        ),
        *with_glyph(
            "\ue191",
            custom_widget.Uptime(
                update_interval=widget_short_update_interval,
            ),
        ),
        *with_glyph(
            "\ue149",
            widget.CheckUpdates(
                custom_command="checkupdates; paru -Qu;",
                display_format="{updates}",
                no_update_string="0",
                colour_have_updates="#d19a66",
                colour_no_updates=theme.widgets["value_fg"],
                update_interval=60*60*2,
            ),
        ),
        *with_glyph(
            "\ue050",
            widget.PulseVolume(
                limit_max_volume=True,
            ),
        ),
        widget.Sep(**sep_defaults),
        widget.Systray(
            padding=5,
        ),
    ]


def widget_clock():
    return [
        widget.Sep(**sep_defaults),
        widget.Clock(
            format="%b %d %H:%M",
            foreground=theme.clock["fg"],
        ),
    ]


# SCREENS
bar_height = 28
spacing_fix = [widget.Spacer(length=1)]

# Primary display
screens = [
    Screen(
        top=bar.Bar(
            widgets_left() + widgets_right() + widget_clock() + spacing_fix,
            size=bar_height,
            background=theme.bar["bg"],
            )
    )
]

# Remaining displays
for i in range(0, get_displays() - 1):
    screens.append(
        Screen(
            top=bar.Bar(
                widgets_left() + widget_clock() + spacing_fix,
                size=bar_height,
                background=theme.bar["bg"],
            )
        )
    )

# QTILE VARIABLES
extension_defaults = dict()
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = "floating_only"
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
