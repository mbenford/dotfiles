palette=dict(
 chalky="#e5c07b",
 coral="#ef596f",
 dark="#5c6370",
 error="#f44747",
 fountainBlue="#2bbac5",
 green="#89ca78",
 invalid="#ffffff",
 lightDark="#7f848e",
 lightWhite="#abb2bf",
 malibu="#61afef",
 purple="#d55fde",
 whiskey="#d19a66",
 deepRed="#be5046",
)

bar = dict(
    fg="#ffffff",
    bg="#282c34",
)

groups = dict(
    fg="#ffffff",
    bg=bar["bg"],
    active_fg="#ffffff",
    inactive_fg="#5c6370",
    current_screen_bg="#61afef",
    other_screens_bg="#7f848e",
)

sep = dict(
    fg="#5c6370",
)

widgets = dict(
    bg=None,
    label_fg="#7f848e",
    value_fg="#61afef",
)

layout_indicator = dict(
    fg="#61afef",
    bg=bar["bg"],
)

screen_indicator = dict(
    active_fg="#ffffff",
    inactive_fg="#5c6370"
)

systray = dict(
    bg=None,
)

clock = dict(
    fg="#ffffff",
    bg=bar["bg"],
)

windows = dict(
    title_fg="#ffffff",
    title_bg=None,
    border="#5c6370",
    border_focus="#61afef",
    border_stack="#d55fde",
    border_stack_focus="#2bbac5",
)
