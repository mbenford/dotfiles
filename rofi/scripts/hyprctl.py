from collections.abc import Iterator
from typing import NamedTuple
from subprocess import run, Popen, DEVNULL
import shlex
import json


def clients() -> Iterator[HyprClient]:
    result = run(shlex.split("hyprctl clients -j"), capture_output=True, text=True)
    for client in json.loads(result.stdout):
        yield HyprClient(
            client["monitor"],
            client["title"],
            client["class"],
            client["pid"],
            client["address"],
            client["workspace"]["id"],
            client["workspace"]["name"],
        )


def binds() -> Iterator[HyprBind]:
    result = run(shlex.split("hyprctl binds -j"), capture_output=True, text=True)
    for bind in json.loads(result.stdout):
        yield HyprBind(
            bind["mouse"],
            bind["modmask"],
            bind["submap"],
            bind["key"],
            bind["description"],
        )


def dispatch(dispatcher: str, **kwargs: object):
    if kwargs:
        dispatcher_args = "{" + ",".join(f"{k}={v}" for k, v in kwargs.items()) + "}"
    else:
        dispatcher_args = ""

    _ = Popen(
        f"hyprctl dispatch 'hl.dsp.{dispatcher}({dispatcher_args})'",
        stdout=DEVNULL,
    )


class HyprClient(NamedTuple):
    monitor: int
    title: str
    className: str
    pid: int
    address: str
    workspace_id: int
    workspace_name: str


class HyprBind(NamedTuple):
    mouse: bool
    modmask: int
    submap: str
    key: str
    description: str
