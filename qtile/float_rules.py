from libqtile.config import Match

rules = [
    Match(wm_class="jetbrains-toolbox"),
    Match(wm_class="pinentry-gtk-2"),
    Match(wm_class="seahorse"),
    Match(wm_class="redshift-gtk"),
    Match(wm_class="volumeicon"),
    Match(wm_class="blueman-manager"),
    Match(wm_class="pavucontrol"),
    Match(wm_class="flameshot"),
    Match(wm_class="guvcview"),
    Match(wm_class="nm-connection-editor"),
    Match(wm_class="xfce4-power-manager-settings"),
    Match(wm_class="lxappearance"),
    Match(wm_class="qalculate-gtk"),
]

# Jetbrains IDEs
rules += [
    Match(wm_class=f"jetbrains-{app[0]}", title="win0")
    for app in [
        ("goland", "GoLand"),
        ("webstorm", "WebStorm"),
        ("pycharm", "PyCharm"),
        ("clion", "CLion"),
    ]
]

