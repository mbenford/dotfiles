#!/usr/bin/env python

import shlex
from subprocess import Popen, DEVNULL
from typing import NamedTuple
import rofi


class Action(NamedTuple):
    name: str
    cmd: str
    confirm: bool = True


actions = [
    Action("Lock", "loginctl lock-session", confirm=False),
    Action("Suspend", "systemctl suspend"),
    Action("Logout", "loginctl terminate-user $USER"),
    Action("Reboot", "loginctl systemctl-session"),
    Action("Shutdown", "systemctl poweroff"),
]

script = rofi.Script(no_custom="true")


@script.start
def show_actions(_: rofi.Context) -> rofi.Result:
    script.set_message(f"Uptime: {get_uptime()}")
    for index, action in enumerate(actions):
        yield rofi.Row(action.name, info=f"action:{index}")


@script.select
def execute_action(ctx: rofi.Context) -> rofi.Result:
    kind, _, value = ctx.info.partition(":")

    if kind == "action":
        action = actions[int(value)]
        if action.confirm:
            script.set_data(str(value))
            script.set_message(f"Confirm {action.name}?")
            yield rofi.Row("Yes", info="confirm:yes")
            yield rofi.Row("No", info="confirm:no")
            return
    elif kind == "confirm" and value == "yes":
        action = actions[int(ctx.data)]
    else:
        yield from show_actions(ctx)
        return

    _ = Popen(shlex.split(action.cmd), stdout=DEVNULL)


def get_uptime() -> str:
    with open("/proc/uptime", "r") as f:
        uptime_seconds = int(float(f.readline().split()[0]))

    if uptime_seconds > 86400:
        return f"{uptime_seconds // 86400} days"
    if uptime_seconds > 3600:
        return f"{uptime_seconds // 3600} hours"
    if uptime_seconds > 60:
        return f"{uptime_seconds // 60} minutes"
    return f"{uptime_seconds} seconds"


if __name__ == "__main__":
    script.run(theme="system.rasi")
