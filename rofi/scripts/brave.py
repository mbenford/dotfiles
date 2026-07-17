#!/usr/bin/env python

from os import getenv
from pathlib import Path
from subprocess import Popen, DEVNULL
import rofi
import json

script = rofi.Script(message="Brave Profiles", no_custom="true")


@script.start
def load_profiles(_: rofi.Context) -> rofi.Result:
    state_file = Path(
        getenv("XDG_CONFIG_HOME", ""), "BraveSoftware/Brave-Browser/Local State"
    )
    with open(state_file, "r") as file:
        data = json.load(file)

    for key, value in sorted(
        data["profile"]["info_cache"].items(), key=lambda x: x[1]["name"]
    ):
        yield rofi.Row(str(value["name"]), info=key, icon="brave")


@script.select
def open_new_window(ctx: rofi.Context) -> rofi.Result:
    _ = Popen(
        ["/usr/bin/brave", f"--profile-directory={ctx.info}"],
        stdout=DEVNULL,
    )


if __name__ == "__main__":
    script.run(theme="brave.rasi")
