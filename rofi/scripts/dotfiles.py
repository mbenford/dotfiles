#!/usr/bin/env python

from os import getenv, path
from pathlib import Path
from subprocess import Popen, DEVNULL
import rofi

script = rofi.Script(no_custom="true")


@script.start
def list_folder(_: rofi.Context) -> rofi.Result:
    folders: list[Path] = []
    for entry in (Path.home() / ".dotfiles").glob("[!.git]*"):
        if not entry.is_dir():
            continue

        folders.append(entry)

    for folder in sorted(folders):
        yield rofi.Row(
            f"{path.basename(folder)}",
            info=str(folder),
            icon="folder",
        )


@script.select
def open_folder(ctx: rofi.Context) -> rofi.Result:
    _ = Popen(
        getenv("TERMINAL", ""),
        cwd=ctx.info,
        stdout=DEVNULL,
    )


if __name__ == "__main__":
    script.run()
