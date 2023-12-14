#!/usr/bin/env python

from subprocess import Popen, DEVNULL
from rofi import RofiScript

actions = [
    dict(name="Suspend", icon="system-suspend", cmd="systemctl suspend"),
    dict(name="Lock", icon="system-lock-screen", cmd="i3lock --blur 10", confirm=False),
    dict(name="Logout", icon="system-log-out", cmd="loginctl terminate-user $USER"),
    dict(name="Reboot", icon="system-reboot", cmd="systemctl reboot"),
    dict(name="Shutdown", icon="system-shutdown", cmd="systemctl poweroff"),
]

class Powermenu(RofiScript):
    def __init__(self):
        super().__init__()
        self.custom_entry(False)


    def generate(self, args):
        self.message(f"Uptime: {self.get_uptime()}")
        for idx, action in enumerate(actions):
            self.row(action["name"], icon=action["icon"], info=idx)


    def execute(self, selected, args):
        action = actions[int(self.info(0))]
        if action.get("confirm", True):
            if self.info(1) is None:
                self.message("Are you sure?")
                self.row("Yes", icon="checkmark", info="y")
                self.row("No", icon="emblem-error", info="n")
                return

            if self.info(1) == "n":
                return

        action = actions[int(self.info(0))]
        Popen(action.get("cmd"), shell=True, stdout=DEVNULL)


    def get_uptime(self):
        with open('/proc/uptime', 'r') as f:
            uptime_seconds = int(float(f.readline().split()[0]))

        if uptime_seconds > 86400:
            return f"{uptime_seconds // 86400} days"
        if uptime_seconds > 3600:
            return f"{uptime_seconds // 3600} hours"
        if uptime_seconds > 60:
            return f"{uptime_seconds // 60} minutes"
        return f"{uptime_seconds} seconds"


if __name__ == "__main__":
    Powermenu().run()
