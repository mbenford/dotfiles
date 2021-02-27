from libqtile import layout, bar, widget, hook
from libqtile.config import EzKey as Key, EzClick as Click, EzDrag as Drag, Group, ScratchPad, DropDown, Screen, Match
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from themes import onedark
import importlib
importlib.reload(onedark)
from themes import onedark as theme
from commands import WindowCommands
from float_rules import rules as custom_float_rules
import layouts
importlib.reload(layouts)
import layouts as custom_layouts
import widgets as custom_widget
import util

# CONSTANTS
terminal = "kitty"
editor = "vim"
browser = "brave"

# KEYS
win_cmds = WindowCommands()


def bind_keys(*key_config):
    return [Key(k[0], *(k[1] if type(k[1]) is list else [k[1]]), desc=k[2]) for k in key_config]


keys = bind_keys(
    # Navigation
    ("M-h", lazy.layout.left(), "Move focus left"),
    ("M-j", lazy.layout.down(), "Move focus down"),
    ("M-k", lazy.layout.up(), "Move focus up"),
    ("M-l", lazy.layout.right(), "Move focus right"),

    ("M-i", lazy.next_screen(), "Focus next screen"),

    ("M-<Tab>", lazy.next_layout(), "Select next layout"),

    # Positioning
    ("M-S-h", lazy.layout.shuffle_left(), "Shuffle window left"),
    ("M-S-j", lazy.layout.shuffle_down(), "Shuffle window down"),
    ("M-S-k", lazy.layout.shuffle_up(), "Shuffle window up"),
    ("M-S-l", lazy.layout.shuffle_right(), "Shuffle window right"),

    # Windows
    ("M-f", lazy.window.toggle_floating(), "Toggle floating"),
    ("M-m", win_cmds.toggle_maximized(layout="mono"), "Toggle mono layout"),
    ("M-S-m", win_cmds.toggle_maximized(layout="max"), "Toggle max layout"),
    ("M-n", win_cmds.to_inactive_group(), "Move window to first inactive group"),
    ("M-q", lazy.window.kill(), "Kill focused window"),

    # Layout specific
    ("M-A-h", [
        lazy.layout.shrink_main().when(layout="tall"),
        lazy.layout.grow_left().when(layout="cols"),
    ], "Grow window left"),
    ("M-A-j", [
        lazy.layout.grow().when(layout="tall"),
        lazy.layout.grow_down().when(layout="cols"),
    ], "Grow window down"),
    ("M-A-k", [
        lazy.layout.shrink().when(layout="tall"),
        lazy.layout.grow_up().when(layout="cols"),
    ], "Grow window up"),
    ("M-A-l", [
        lazy.layout.grow_main().when(layout="tall"),
        lazy.layout.grow_right().when(layout="cols"),
    ], "Grow window right"),

    ("M-A-m", lazy.layout.maximize().when(layout="tall"), "Maximize window"),
    ("M-A-s", lazy.layout.toggle_split().when(layout="cols"), "Toggle split"),
    ("M-A-n", [
        lazy.layout.reset().when(layout="tall"),
        lazy.layout.normalize().when(layout="cols"),
    ], "Reset layout"),
    ("M-A-C-j", lazy.layout.swap_left().when(layout="cols"), "Shuffle window right"),
    ("M-A-C-l", lazy.layout.swap_right().when(layout="cols"), "Shuffle window right"),
    ("M-A-f", lazy.layout.flip().when(layout="tall"), "Shuffle window right"),

    # Applications
    ("M-<Return>", lazy.spawn(terminal), "Launch terminal"),
    ("M-b", lazy.spawn(browser), "Launch browser"),
    ("M-S-b", lazy.spawn(f"{browser} --incognito"), "Launch browser (incognito)"),

    # Launcher
    ("M-<space>", lazy.spawn("rofi -show drun"), "Launch rofi (drun)"),
    ("M-S-<space>", lazy.spawn("rofi -show run"), "Launch rofi (run)"),
    ("A-<Tab>", lazy.spawn("./.dotfiles/bin/rofi-qtile-windows"), "Launch rofi (windows)"),

    ("M-e", lazy.spawn("./.dotfiles/bin/rofi-config-files-menu"), "Launch rofi (window)"),
    ("M-S-q", lazy.spawn("./.dotfiles/bin/rofi-power-menu"), "Launch rofi (window)"),

    # Volume
    ("<XF86AudioRaiseVolume>", lazy.spawn("pamixer --increase 10"), "Launch rofi (window)"),
    ("<XF86AudioLowerVolume>", lazy.spawn("pamixer --decrease 10"), "Launch rofi (window)"),
    ("<XF86AudioMute>", lazy.spawn("pamixer --toggle-mute"), "Launch rofi (window)"),

    # Media
    ("<XF86AudioPlay>", lazy.spawn("./.dotfiles/bin/spotifyctl play-pause"), "Launch rofi (window)"),
    ("<XF86AudioPrev>", lazy.spawn("./.dotfiles/bin/spotifyctl prev"), "Launch rofi (window)"),
    ("<XF86AudioNext>", lazy.spawn("./.dotfiles/bin/spotifyctl next"), "Launch rofi (window)"),

    # Misc
    ("<Print>", lazy.spawn("flameshot gui"), "Launch flameshot"),

    # Qtile
    ("M-C-r", lazy.restart(), "Restart qtile"),
    ("M-C-q", lazy.shutdown(), "Shutdown qtile"),
)

# GROUPS
groups = [Group(i) for i in "123890"]

for g in groups:
    keys += bind_keys(
        ("M-" + g.name, lazy.group[g.name].toscreen(toggle=False), "Switch to group " + g.name),
        ("M-S-" + g.name, lazy.window.togroup(g.name, switch_group=True), "Move focused window to group " + g.name),
        ("M-C-" + g.name, lazy.window.togroup(g.name, switch_group=False), "Move focused window to group " + g.name),
    )

groups += [
    ScratchPad("scratchpad", [
        DropDown("terminal", terminal, x=0.3, y=0.2, width=0.4, height=0.6, opacity=1.0),
        DropDown("qalc", f"{terminal} qalc", x=0.4, y=0.3, width=0.2, height=0.4, opacity=1.0),
        DropDown("notes", f"{terminal} {editor} ./notes.txt", x=0.3, y=0.2, width=0.4, height=0.6, opacity=1.0),
        DropDown("spotify", "spotify", x=0.3, y=0.1, width=0.4, height=0.8, opacity=1.0),
    ]),
]

keys += bind_keys(
    ("M-S-<Return>", lazy.group["scratchpad"].dropdown_toggle("terminal"), ""),
    ("M-c", lazy.group["scratchpad"].dropdown_toggle("qalc"), ""),
    ("M-v", lazy.group["scratchpad"].dropdown_toggle("notes"), ""),
    ("M-s", lazy.group["scratchpad"].dropdown_toggle("spotify"), ""),
)

# MOUSE
mouse = [
    Drag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click("M-S-1", lazy.window.disable_floating()),
    Click("M-C-1", lazy.window.bring_to_front()),
]

# LAYOUTS
layout_defaults = dict(
    margin=5,
    border_width=2,
    border_normal=theme.windows["border"],
    border_focus=theme.windows["border_focus"],
    border_normal_stack=theme.windows["border_stack"],
    border_focus_stack=theme.windows["border_stack_focus"],
)
margin_single_window = [5, 290, 5, 290]


layouts = [
    layout.MonadTall(
        **layout_defaults,
        name="tall",
        single_margin=margin_single_window,
    ),
    custom_layouts.Columns(
        **layout_defaults,
        name="cols",
        num_columns=4,
        border_on_single=True,
    ),
    layout.Stack(
        **(layout_defaults | dict(margin=margin_single_window)),
        name="mono",
        num_stacks=1,
    ),
    layout.Stack(
        **layout_defaults,
        name="max",
        num_stacks=1,
    ),
    custom_layouts.ThreeColumns(
        **layout_defaults,
        main_size=50,
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
            font='Material Icons',
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
            this_current_screen_border=theme.groups["current_screen_bg"],
            this_screen_border=theme.groups["current_screen_bg"],
            other_screen_border=theme.groups["other_screens_bg"],
            other_current_screen_border=theme.groups["other_screens_bg"],
            margin_y=5,
        ),
        widget.Sep(**sep_defaults),
        widget.CurrentScreen(
            font="Material Icons",
            active_text="\ue30c",
            inactive_text="\ue30c",
            active_color=theme.screen_indicator["active_fg"],
            inactive_color=theme.screen_indicator["inactive_fg"],
        ),
        widget.Sep(**sep_defaults),
        widget.CurrentLayout(
            foreground=theme.layout_indicator["fg"],
            background=theme.layout_indicator["bg"],
        ),
        widget.Sep(**sep_defaults),
        widget.WindowName(
            width=500,
            padding=10,
            show_state=False,
            max_chars=60,
            format="{name}",
            foreground=theme.windows["title_fg"],
            background=theme.windows["title_bg"],
        ),
    ]


def widgets_center():
    return [
        widget.Spacer(),
        widget.Clock(
            format="%a %d %H:%M",
            foreground=theme.clock["fg"],
            background=theme.clock["bg"],
        ),
        widget.Spacer(),
    ]


def widgets_right():
    return [
        *with_glyph(
            '\ue9e4',
            widget.CPU(
                update_interval=widget_short_update_interval,
                format="{load_percent:.0f}%",
            ),
        ),
        *with_glyph(
            '\ue322',
            widget.Memory(
                update_interval=widget_short_update_interval,
                format="{MemPercent:.0f}%",
            ),
        ),
        *with_glyph(
            '\ue623',
            widget.DF(
                visible_on_warn=False,
                format="{uf}{m}",
            ),
        ),
        *with_glyph(
            '\ue1ff',
            custom_widget.SensorTemp(
                update_interval=widget_short_update_interval,
                sensor="coretemp",
                label="Package id 0",
                warning_threshold=80,
                critical_threshold=95,
            ),
        ),
        *with_glyph(
            '\ue332',
            custom_widget.SensorFan(
                update_interval=widget_short_update_interval,
                sensor="dell_smm",
                label="",
                warning_threshold=5000,
                critical_threshold=6000,
            ),
        ),
        *with_glyph(
            '\ue63e',
            widget.Wlan(
                update_interval=widget_short_update_interval,
                interface="wlp2s0",
                format="{percent:2.0%}",
                disconnected_message="off",
            ),
        ),
        *with_glyph(
            '\ue0da',
            custom_widget.VPN(
                update_interval=widget_short_update_interval,
            ),
        ),
        *with_glyph(
            '\ue191',
            custom_widget.Uptime(
                update_interval=widget_short_update_interval,
            ),
        ),
        *with_glyph(
            '\ue149',
            widget.CheckUpdates(
                dist="Arch",
                display_format="{updates}",
                no_update_string="0",
                colour_have_updates=theme.widgets["value_fg"],
                colour_no_updates=theme.widgets["value_fg"],
            ),
        ),
        *with_glyph(
            '\ue050',
            widget.PulseVolume(
                limit_max_volume=True,
            ),
        ),
        *with_glyph(
            '\ue1a4',
            widget.Battery(
                format="{percent:2.0%}",
                show_short_text=False,
            ),
        ),
        widget.Systray(
            padding=5,
        ),
        widget.Spacer(
            length=10,
        ),
    ]


# SCREENS
bar_height = 28
spacing_fix = [widget.Spacer(length=1)]

# Primary display
screens = [
    Screen(
        top=bar.Bar(
            widgets_left() + widgets_center() + widgets_right() + spacing_fix,
            size=bar_height,
            background=theme.bar["bg"]
        )
    )
]

# Remaining displays
for i in range(0, util.get_displays() - 1):
    screens.append(
        Screen(
            top=bar.Bar(
                widgets_left() + widgets_center() + spacing_fix,
                size=bar_height,
                background=theme.bar["bg"])
        )
    )

# QTILE VARIABLES
extension_defaults = dict()
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
