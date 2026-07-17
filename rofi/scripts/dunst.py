#!/usr/bin/env python

from subprocess import DEVNULL, run, Popen
import re
import shlex
import json
import rofi

script = rofi.Script(no_custom="true")


@script.start
def load_history(_: rofi.Context) -> rofi.Result:
    result = run(shlex.split("dunstctl history"), capture_output=True, text=True)
    notifications = json.loads(result.stdout)

    for item in notifications["data"][0]:
        id = str(item["id"]["data"])
        title = clear_text(item["summary"]["data"])
        body = clear_text(item["body"]["data"])

        yield rofi.Row(f"{title}\r{body}", info=id)


@script.select
def show_notification(ctx: rofi.Context) -> rofi.Result:
    id = ctx.info
    _ = Popen(["dunstctl", "history-pop", id], stdout=DEVNULL)


def clear_text(value: str) -> str:
    return re.sub(r"<[^>]+>", "", value).replace("\n", " ")


if __name__ == "__main__":
    script.run(theme="dunst.rasi", eh="2")
