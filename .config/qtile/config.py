from libqtile import layout, bar, widget
from libqtile.config import EzKey as Key, EzClick as Click, EzDrag as Drag, Group, ScratchPad, DropDown, Screen, Match
from libqtile.lazy import lazy
# from libqtile.log_utils import logger

import os

import widgets as custom_widget
import util
from themes import very_first as theme

### CONSTANTS ###
terminal = "kitty"
editor = "vim"
browser = "brave"

### KEYS ###
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
	["M-m", lazy.group.setlayout("max"), "Kill focused window"],
	["M-w", lazy.window.kill(), "Kill focused window"],

	# Applications
	["M-<Return>", lazy.spawn(terminal), "Launch terminal"],
	["M-<space>", lazy.spawn("rofi -show drun"), "Launch rofi (drun)"],
	["M-S-<space>", lazy.spawn("rofi -show run"), "Launch rofi (run)"],
	["M-C-<space>", lazy.spawn("rofi -show window"), "Launch rofi (window)"],

	["M-e", lazy.spawn(f"TERMINAL={terminal} EDITOR={editor} ./.dotfiles/bin/config-files.sh"), "Launch rofi (window)"],
	["M-b", lazy.spawn(browser), "Launch rofi (window)"],

	# Qtile
	["M-C-r", lazy.restart(), "Restart qtile"],
	["M-C-q", lazy.shutdown(), "Shutdown qtile"],
]]

### GROUPS ###
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

### MOUSE ###
mouse = [
	Drag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click("M-S-1", lazy.window.disable_floating())
]

### LAYOUTS ###
layouts = [
	layout.MonadTall(
		name="tall",
		margin=5,
		border_width=2,
   	border=theme.windows["border"],
		border_focus=theme.windows["border_focus"],
		single_margin=[5, 200, 5, 200],
	),
	layout.Stack(
		name="max",
		num_stacks=1,
		margin=5,
		border_width=2,
		border=theme.windows["border"],
		border_focus=theme.windows["border_focus"],
	),
]

floating_layout = layout.Floating(
	border_focus=theme.windows["border_focus"],
	float_rules=[
		*layout.Floating.default_float_rules,
		Match(wm_class="jetbrains-goland", title="win0"),
		Match(wm_class="jetbrains-goland", title="Welcome to GoLand"),
		Match(wm_class="microsoft teams - preview", title="Microsoft Teams - Preview"),
		Match(wm_class="Enpass", title="Enpass Assistant"),
	]
)

### WIDGETS ###
widget_defaults = dict(
	font="Ubuntu Mono",
	fontsize=16,
	foreground=theme.widgets["fg"],
	background=theme.widgets["bg"],
)
widget_short_update_interval=5
widget_long_update_interval=600

def label(name, value):
	return "{} <span foreground='{}'>{}</span>".format(name, theme.widgets["value_fg"], value)

def widgets(primary):
	widgets = [
		widget.GroupBox(
			rounded=False,
			use_mouse_wheel=False,
			disable_drag=True,
			foreground=theme.groups["fg"],
			background=theme.groups["bg"],
			highlight_method="block",
			active=theme.groups["active_fg"],
			inactive=theme.groups["inactive_fg"],
			this_current_screen_border=theme.groups["current_screen_bg"],
			this_screen_border=theme.groups["other_screens_bg"],
			other_screen_border=theme.groups["other_screens_bg"],
			other_current_screen_border=theme.groups["current_screen_bg"],
		),
		widget.CurrentLayout(
			foreground=theme.layout_indicator["fg"],
			background=theme.layout_indicator["bg"],
		),
		custom_widget.WindowName(
			padding=10,
			show_state=False,
			max_chars=100,
		),
	]

	if primary:
		widgets += [
			widget.CPU(
				update_interval=widget_short_update_interval,
				format=label("cpu", "{load_percent:.0f}%"),
			),
			widget.Memory(
				update_interval=widget_short_update_interval,
				format=label("mem", "{MemPercent:.0f}%"),
			),
			widget.DF(
				visible_on_warn=False,
				format=label("ssd", "{uf}{m}"),
			),
			widget.ThermalSensor(
				update_interval=widget_short_update_interval,
				tag_sensor="Package id 0",
				fmt=label("temp", "{}"),
			),
			widget.Wlan(
				update_interval=widget_short_update_interval,
				interface="wlp2s0",
				format=label("wifi", "{percent:2.0%}"),
			),
			custom_widget.VPN(
				update_interval=widget_short_update_interval,
				fmt=label("vpn", "{}"),
			),
			custom_widget.Uptime(
				update_interval=widget_short_update_interval,
				fmt=label("uptime", "{}"),
			),
			widget.CheckUpdates(
				dist="Arch",
				display_format="{updates}",
				fmt=label("updates", "{}"),
			),
			widget.Battery(
				format=label("batt", "{percent:2.0%}"),
				show_short_text=False,
			),
			widget.Systray(
				padding=5,
			),
		]

	widgets += [
		widget.Spacer(
			length=10,
		),
		widget.Clock(
			format="%a %d, %H:%M",
			foreground=theme.clock["fg"],
			background=theme.clock["bg"],
		),
	]

	return widgets

### SCREENS ###
screens = [
	Screen(
		top=bar.Bar(widgets(primary=i==0),
		size=28,
		background=theme.bar["bg"])
	) for i in range(0, util.get_displays())
]

### QTILE VARIABLES ###
extension_defaults = dict()
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"
