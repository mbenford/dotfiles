#!/usr/bin/env python

from collections.abc import Iterator
from subprocess import Popen, DEVNULL
from os import getenv, path
from pathlib import Path
from textwrap import shorten
import rofi

script = rofi.Script(no_custom="true")


@script.start
def list_projects(_: rofi.Context) -> rofi.Result:
    for project in sorted(walk(Path.home() / "dev"), key=path.basename):
        name = shorten(path.basename(project), 40, placeholder="...")
        location = shorten(project.parent.name, 20, placeholder="...")
        yield rofi.Row(
            name,
            location,
            icon="folder-development",
            info=str(project),
            meta=str(project),
        )


@script.select
def open_project_folder(ctx: rofi.Context) -> rofi.Result:
    _ = Popen(
        getenv("TERMINAL", ""),
        cwd=ctx.info,
        stdout=DEVNULL,
    )


def walk(root: Path) -> Iterator[Path]:
    for entry in root.iterdir():
        if entry.is_file():
            continue

        if path.isdir(entry / ".git"):
            yield entry
        else:
            yield from walk(entry)


if __name__ == "__main__":
    script.run(theme_str="window { width: 700px; }")
