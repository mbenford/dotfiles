from libqtile.config import Match

rules = [
    Match(wm_class="jetbrains-toolbox"),
    Match(wm_class="microsoft teams - preview", title="Microsoft Teams - Preview"),
    Match(wm_class="Enpass", title="Enpass Assistant"),
    Match(wm_class="redshift-gtk"),
    Match(wm_class="volumeicon"),
    Match(wm_class="blueman-manager"),
    Match(wm_class="pavucontrol"),
    Match(wm_class="flameshot"),
    Match(wm_class="guvcview"),
    Match(wm_class="nm-connection-editor"),
]

# Jetbrains IDEs
jetbrains_apps = [
    ("goland", "GoLand"),
    ("webstorm", "WebStorm"),
    ("pycharm", "PyCharm"),
]

for app in jetbrains_apps:
    rules += [
        Match(wm_class=f"jetbrains-{app[0]}", title="win0"),
        Match(wm_class=f"jetbrains-{app[0]}", title=f"Welcome to {app[1]}"),
    ]
