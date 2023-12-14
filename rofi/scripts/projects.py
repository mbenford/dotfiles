#!/usr/bin/env python
from subprocess import Popen, DEVNULL
from os import getenv, path
from pathlib import Path
from functools import partial
from rofi import RofiScript

terminal = getenv("TERMINAL", "")
editor = getenv("EDITOR", "")
home = str(Path.home())
basedir = f"{home}/dev"


class Projects(RofiScript):
    def __init__(self):
        super().__init__()
        self.custom_entry(False)
        self.markup_rows(True)


    def generate(self, args):
        def walk(root):
            for entry in Path(root).iterdir():
                if entry.is_file():
                    continue

                if path.isdir(path.join(entry, ".git")):
                    yield entry
                else:
                    yield from walk(entry)

        for project in sorted(walk(basedir), key=path.basename):
            name = path.basename(project)
            location = path.dirname(project).replace(home, '~')
            self.row(f"{name} <i><small>{location}</small></i>", icon='folder-development',
                    info=project, meta=project)


    def execute(self, selected, args):
        project = self.info(0)
        popen = partial(Popen, cwd=project, shell=True, stdout=DEVNULL)
        popen(terminal)


if __name__ == "__main__":
    Projects().run()
