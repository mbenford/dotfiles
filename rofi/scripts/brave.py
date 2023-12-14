#!/usr/bin/env python

from os import getenv
from pathlib import Path
from subprocess import Popen, DEVNULL
from rofi import RofiScript
import json


config_dir = getenv('XDG_CONFIG_HOME')
browser = "/usr/bin/brave"
state_file = Path(config_dir, "BraveSoftware/Brave-Browser/Local State")

class BraveProfiles(RofiScript):
    def __init__(self):
        super().__init__()
        self.hotkeys(True)
        self.custom_entry(False)
        self.markup_rows(True)


    def generate(self, args):
        self.message("Available profiles")
        with open(state_file, "r") as file:
            data = json.load(file)
            for key, value in data["profile"]["info_cache"].items():
                self.row(value["name"], icon="brave", info=key)


    def execute(self, selected, args):
        profile = self.info(0)
        args = [browser, f"--profile-directory={profile}"]

        if self.retv() == 10:
            args.append("--incognito")

        Popen(args, stdout=DEVNULL, stderr=DEVNULL)


if __name__ == "__main__":
    BraveProfiles().run()
