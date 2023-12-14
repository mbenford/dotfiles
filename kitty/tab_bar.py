from kitty.fast_data_types import (
    Screen,
    get_options,
)
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    draw_title,
    as_rgb,
)


opts = get_options()
tab_bar_bg = as_rgb(color_as_int(opts.tab_bar_background))
active_tab_fg = as_rgb(color_as_int(opts.active_tab_foreground))
active_tab_bg = as_rgb(color_as_int(opts.active_tab_background))
inactive_tab_fg = as_rgb(color_as_int(opts.inactive_tab_foreground))
inactive_tab_bg = as_rgb(color_as_int(opts.inactive_tab_background))
separators = ("", "")

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_tab_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    fg = active_tab_fg if tab.is_active else inactive_tab_fg
    bg = active_tab_bg if tab.is_active else inactive_tab_bg

    screen.cursor.fg = bg
    screen.cursor.bg = tab_bar_bg
    screen.draw(separators[0])

    screen.cursor.fg = fg
    screen.cursor.bg = bg
    draw_title(draw_data, screen, tab, index)

    screen.cursor.fg = bg
    screen.cursor.bg = tab_bar_bg
    screen.draw(separators[1])

    if not is_last:
        screen.draw(" ")

    return screen.cursor.x
