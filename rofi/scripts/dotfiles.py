#!/usr/bin/env python

from os import getenv, path
from pathlib import Path
from subprocess import Popen, DEVNULL
from functools import partial
from rofi import RofiScript

terminal = getenv("TERMINAL")
editor = getenv("EDITOR")
shell = getenv("SHELL")
home = str(Path.home())
basedir = f"{home}/.dotfiles"

class Dotfiles(RofiScript):
    def __init__(self):
        super().__init__()
        self.custom_entry(False)
        self.markup_rows(True)


    def generate(self, args):
        folders = []
        for entry in Path(basedir).glob("[!.git]*"):
            if not entry.is_dir():
                continue

            folders.append(entry)

        for folder in sorted(folders):
            self.row(f"{path.basename(folder)}", icon="folder", info=folder)


    def execute(self, selected, args):
        file = self.info(0)
        popen = partial(Popen, cwd=file, shell=True, stdout=DEVNULL)
        popen(terminal)


if __name__ == "__main__":
    Dotfiles().run()
