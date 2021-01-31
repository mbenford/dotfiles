from libqtile import layout, bar, widget
from libqtile.config import EzKey as Key, EzClick as Click, EzDrag as Drag, Group, ScratchPad, DropDown, Screen, Match
from libqtile.lazy import lazy

from commands import WindowCommands, MediaCommands
import widgets as custom_widget
import util
from themes import very_first as theme

# CONSTANTS
terminal = "kitty"
editor = "vim"
browser = "brave"

# KEYS
win_cmds = WindowCommands()
media_cmds = MediaCommands()

keys = [Key(k[0], k[1], desc=k[2]) for k in [
    # Navigation
    ["M-i", lazy.layout.up(), "Move focus up"],
    ["M-j", lazy.layout.left(), "Move focus left"],
    ["M-k", lazy.layout.down(), "Move focus down"],
    ["M-l", lazy.layout.right(), "Move focus right"],

    ["M-<Tab>", lazy.screen.toggle_group(), "Toggle focused group"],
    ["A-<Tab>", lazy.layout.next(), "Move focus to next window"],

    ["M-<Left>", lazy.prev_screen(), "Move focus to next screen"],
    ["M-<Right>", lazy.next_screen(), "Move focus to previous screen"],

    # Positioning
    ["M-S-i", lazy.layout.shuffle_up(), "Shuffle window up"],
    ["M-S-j", lazy.layout.shuffle_left(), "Shuffle window left"],
    ["M-S-k", lazy.layout.shuffle_down(), "Shuffle window down"],
    ["M-S-l", lazy.layout.shuffle_right(), "Shuffle window right"],

    # Layout
    ["M-f", lazy.window.toggle_floating(), "Toggle floating"],
    ["M-m", win_cmds.toggle_max(), "Kill focused window"],
    ["M-n", win_cmds.to_inactive_group(), "Kill focused window"],
    ["M-w", lazy.window.kill(), "Kill focused window"],

    # Applications
    ["M-<Return>", lazy.spawn(terminal), "Launch terminal"],
    ["M-b", lazy.spawn(browser), "Launch rofi (window)"],
    ["M-<space>", lazy.spawn("rofi -show drun"), "Launch rofi (drun)"],
    ["M-S-<space>", lazy.spawn("rofi -show run"), "Launch rofi (run)"],
    ["M-C-<space>", lazy.spawn("rofi -show window"), "Launch rofi (window)"],

    ["M-e", lazy.spawn("./.dotfiles/bin/config-files"), "Launch rofi (window)"],
    ["M-S-q", lazy.spawn("./.dotfiles/bin/power-menu"), "Launch rofi (window)"],

    # Media
    ["<XF86AudioPlay>", media_cmds.play_pause(), "Launch rofi (window)"],
    ["<XF86AudioPrev>", media_cmds.previous(), "Launch rofi (window)"],
    ["<XF86AudioNext>", media_cmds.next(), "Launch rofi (window)"],

    # Qtile
    ["M-C-r", lazy.restart(), "Restart qtile"],
    ["M-C-q", lazy.shutdown(), "Shutdown qtile"],
]]

# GROUPS
groups = [Group(i) for i in "1234567890"]

for g in groups:
    keys.extend([Key(k[0], k[1], desc=k[2]) for k in [
        ["M-" + g.name, lazy.group[g.name].toscreen(toggle=False), "Switch to group " + g.name],
        ["M-S-" + g.name, lazy.window.togroup(g.name, switch_group=True), "Move focused window to group " + g.name],
        ["M-C-" + g.name, lazy.window.togroup(g.name, switch_group=False), "Move focused window to group " + g.name],
    ]])

groups += [
    ScratchPad("scratchpad", [
        DropDown("qalc", "{} qalc".format(terminal), x=0.4, y=0.3, width=0.2, height=0.4, opacity=1.0),
    ]),
]

keys.extend([Key(k[0], k[1], desc=k[2]) for k in [
    ["M-c", lazy.group["scratchpad"].dropdown_toggle("qalc"), ""],
]])

# MOUSE
mouse = [
    Drag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click("M-S-1", lazy.window.disable_floating())
]

# LAYOUTS
layout_defaults = dict(
    margin=5,
    border_width=2,
    border=theme.windows["border"],
    border_focus=theme.windows["border_focus"],
)
margin_single_window = [5, 250, 5, 250]

layouts = [
    layout.MonadTall(
        **layout_defaults,
        name="tall",
        single_margin=margin_single_window,
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
    layout.Columns(
        **layout_defaults,
        name="cols",
        num_columns=4,
    ),
]

floating_layout = layout.Floating(
    border_focus=theme.windows["border_focus"],
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="jetbrains-toolbox"),
        Match(wm_class="jetbrains-goland", title="win0"),
        Match(wm_class="jetbrains-goland", title="Welcome to GoLand"),
        Match(wm_class="jetbrains-webstorm", title="win0"),
        Match(wm_class="jetbrains-webstorm", title="Welcome to WebStorm"),
        Match(wm_class="jetbrains-pycharm", title="win0"),
        Match(wm_class="jetbrains-pycharm", title="Welcome to PyCharm"),
        Match(wm_class="microsoft teams - preview", title="Microsoft Teams - Preview"),
        Match(wm_class="Enpass", title="Enpass Assistant"),
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
        widget.CurrentLayout(
            foreground=theme.layout_indicator["fg"],
            background=theme.layout_indicator["bg"],
        ),
        widget.Sep(**sep_defaults),
        custom_widget.WindowName(
            width=500,
            padding=10,
            show_state=False,
            max_chars=60,
            foreground=theme.windows["title_fg"],
            background=theme.windows["title_bg"],
        ),
    ]


def widgets_center():
    return [
        widget.Spacer(),
        widget.Clock(
            format="%a %d, %H:%M",
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
            ),
        ),
        *with_glyph(
            '\ue332',
            custom_widget.SensorFan(
                update_interval=widget_short_update_interval,
                sensor="dell_smm",
                label="",
            ),
        ),
        *with_glyph(
            '\ue63e',
            widget.Wlan(
                update_interval=widget_short_update_interval,
                interface="wlp2s0",
                format="{percent:2.0%}",
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
                colour_have_updates=theme.widgets["value_fg"],
                colour_no_updates=theme.widgets["value_fg"],
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
wmname = "LG3D"
