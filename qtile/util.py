import os
from libqtile.config import EzConfig, EzKey, KeyChord
from libqtile.log_utils import logger


class EzKeyChord(EzConfig, KeyChord):
    def __init__(self, keydef, *submappings, mode = ""):
        modkeys, key = self.parse(keydef)
        super().__init__(modkeys, key, *submappings, mode)


class Rofi:
    def __init__(self, scripts_dir):
        self.scripts_dir = scripts_dir

    def show(self, mode, script=None):
        if script is None:
            script = mode

        return f"rofi -show {mode} -modi '{mode}:{self.scripts_dir}/{script}' " \
            f"-kb-accept-alt '' -kb-accept-custom '' -kb-custom-1 'Shift+Return' -kb-custom-2 'Control+Return'"


def get_displays():
    displays = os.popen(
        "xrandr | grep -E '\sconnected\s(primary|[0-9])'"
    ).read()[:-1].split("\n")
    return len(displays)


def bind_keys(*config):
    bindings = []

    for c in config:
        keydef = c[0]
        actions = c[1] if type(c[1]) is list else [c[1]]
        desc = c[2]

        if type(actions[0]) is tuple:
            bindings.append(EzKeyChord(keydef, bind_keys(*actions)))
        else:
            bindings.append(EzKey(keydef, *actions, desc=desc))

    return bindings
