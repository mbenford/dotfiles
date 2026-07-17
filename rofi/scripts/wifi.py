#!/usr/bin/env python

from subprocess import run
import shlex
import rofi

script = rofi.Script(no_custom="true", use_hot_keys="true", message="CTRL+R to refresh")


@script.start
def list_networks(_: rofi.Context) -> rofi.Result:
    yield from scan_networks(rescan=False)


@script.custom_key(1)
def refresh_networks(ctx: rofi.Context) -> rofi.Result:
    yield from scan_networks(rescan=True)


def scan_networks(rescan: bool) -> rofi.Result:
    cmd = f"nmcli -t dev wifi list --rescan {'yes' if rescan else 'no'}"
    result = run(shlex.split(cmd), capture_output=True, text=True)
    for line in result.stdout.splitlines():
        values = line.replace("\\:", "-").split(":")
        conn_name = values[2]
        if conn_name != "":
            yield rofi.Row(f"{values[0]} {conn_name}", values[7])


if __name__ == "__main__":
    script.run(theme_str="inputbar{enabled:false;}", kb_custom_1="Control+r")
