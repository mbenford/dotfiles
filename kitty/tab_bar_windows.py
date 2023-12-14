from kitty.boss import Boss
from kitty.fast_data_types import (
    Screen,
    get_boss,
    get_options,
)
from kitty.rgb import to_color
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
)


class Color:
    def __init__(self, fg: str, bg: str):
        def hex_to_rgb(hex: str) -> int:
            return as_rgb(color_as_int(to_color(hex)))

        self.fg = hex_to_rgb(fg)
        self.bg = hex_to_rgb(bg)


boss: Boss = get_boss()
opts = get_options()

default_color = Color("#cad3f5", "#1e2031")
tab_active_color = Color("#24273a", "#c6a0f6")
tab_inactive_color = Color("#939ab7", "#363a4f")
window_active_color = Color("#cad3f5", "#1e2031")
window_inactive_color = Color("#939ab7", "#1e2031")
window_separator_color = Color("#363a4f", "#1e2031")

window_title_min_length = 5
window_separator = "│"

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_tab_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    return screen.cursor.x
    if is_last:
        draw_left(screen)
        draw_right(screen)

    return screen.cursor.x


def draw_left(screen: Screen):
    screen.cursor.italic = False
    screen.cursor.bold = True

    for _, win in list(enumerate(boss.active_tab)):
        title = win.title + " " * (window_title_min_length - len(win.title))
        color = window_active_color if win.is_active else window_inactive_color
        screen.cursor.fg = color.fg
        screen.cursor.bg = default_color.bg
        screen.draw(f" {title} ")

        screen.cursor.fg = window_separator_color.fg
        screen.cursor.bg = window_separator_color.bg
        screen.draw(window_separator)


def draw_right(screen: Screen):
    screen.cursor.italic = False
    screen.cursor.bold = False

    tab_manager = boss.active_tab_manager
    active_tab = tab_manager.active_tab
    tabs = tab_manager.tabs
    text = f"{'STACKED' if active_tab.current_layout.name == 'stack' else ''} {tab_manager.active_tab_idx + 1}/{len(tabs)} "
    screen.cursor.x = screen.columns - len(text)
    screen.cursor.fg = default_color.fg
    screen.cursor.bg = default_color.bg
    screen.draw(text.upper())
