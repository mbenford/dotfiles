#!/usr/bin/env python
import json
from textwrap import shorten
import rofi
import hyprctl

script = rofi.Script(prompt="clients", no_custom="true")


@script.start
def list_clients(_: rofi.Context) -> rofi.Result:
    for client in hyprctl.clients():
        if client.workspace_name.startswith("special"):
            continue

        yield rofi.Row(
            shorten(client.title, 50, placeholder="..."),
            meta=client.title,
            info=f"{client.monitor};{client.workspace_id};{client.address}",
        )


@script.select
def focus_client(ctx: rofi.Context) -> rofi.Result:
    (monitor, workspace_id, address) = ctx.info.split(";")
    hyprctl.dispatch("focus", monitor=monitor)
    hyprctl.dispatch("focus", workspace=workspace_id)
    hyprctl.dispatch("focus", window=f'"address:{address}"')


if __name__ == "__main__":
    script.run(theme_str="window { width: 1000px; }")
