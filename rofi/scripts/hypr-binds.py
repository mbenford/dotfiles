#!/usr/bin/env python

from enum import IntFlag
from typing import NamedTuple
import rofi
import hyprctl

script = rofi.Script(no_custom="true")


@script.start
def execute(_: rofi.Context) -> rofi.Result:
    for bind in sorted(parse_binds(), key=lambda b: b.group):
        yield rofi.Row(bind.keymap, bind.desc, meta=bind.group)


def parse_binds() -> list[Bind]:
    binds: list[Bind] = []
    submaps: dict[str, str] = {}

    for bind in sorted(hyprctl.binds(), key=lambda b: b.submap):
        if bind.description == "":
            continue

        keymap = "+".join([*decode_modmask(bind.modmask), bind.key])
        submap = bind.submap
        group, desc = parse_description(bind.description)

        if group == "Submap":
            submaps[desc] = keymap
            continue

        if submap in submaps:
            keymap = f"{submaps.get(submap)}>{keymap}"

        binds.append(Bind(keymap, desc, group))

    return binds


def decode_modmask(mask: int) -> list[str]:
    return [mod.name.title() for mod in Mod if mask & mod]


def parse_description(description: str) -> tuple[str, str]:
    if description == "":
        return ("", "")

    parts = [part.strip() for part in description.split(":")]
    if len(parts) == 1:
        return ("", parts[0])

    return (parts[0], parts[1])


class Bind(NamedTuple):
    keymap: str
    desc: str
    group: str


class Mod(IntFlag):
    SUPER = 64
    CTRL = 4
    SHIFT = 1
    ALT = 8


if __name__ == "__main__":
    script.run(theme="hypr-binds.rasi")
