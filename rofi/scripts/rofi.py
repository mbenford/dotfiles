from collections import defaultdict
from collections.abc import Iterator
from os import getenv
from pathlib import Path
from typing import Callable
from itertools import chain
import subprocess
import sys

__all__ = ["Script", "Context", "Row", "Result"]


class Script:
    _opts: dict[str, str]
    _ctx: Context
    _start_handler: Handler | None
    _select_handler: Handler | None
    _custom_key_handlers: dict[int, Handler]

    def __init__(self, **kwargs: str):
        self._opts = kwargs
        self._ctx = Context()
        self._start_handler = None
        self._select_handler = None
        self._custom_key_handlers = {}

    def __getattr__(self, name: str) -> Callable[[str], None]:
        if not name.startswith("set_"):
            raise AttributeError(f"'Script' object has no attribute '{name}'")

        key = name[4:]

        def setter(value: str) -> None:
            print_option(key, value)

        return setter

    def run(self, **kwargs: str) -> None:
        if self._ctx.retv is None:
            name = Path(sys.argv[0]).stem
            args = chain.from_iterable(
                ("-" + k.replace("_", "-"), v) for k, v in kwargs.items()
            )
            rofi_cmd = [
                "rofi",
                "-show",
                name,
                "-modes",
                f"{name}:{sys.argv[0]}",
                *args,
            ]
            _ = subprocess.Popen(rofi_cmd)
            return

        for key, value in self._opts.items():
            print_option(key, value)

        result: Result = None
        match self._ctx.retv:
            case 0:
                if self._start_handler:
                    result = self._start_handler(self._ctx)
            case 1:
                if self._select_handler:
                    result = self._select_handler(self._ctx)
            case v if 10 <= v <= 28:
                handler = self._custom_key_handlers.get(v - 9)
                if handler:
                    result = handler(self._ctx)
            case _:
                pass

        if result is not None:
            print_rows(list(result))

    def start(self, handler: Handler) -> Handler:
        self._start_handler = handler
        return handler

    def select(self, handler: Handler) -> Handler:
        self._select_handler = handler
        return handler

    def custom_key(self, key: int) -> Callable[[Handler], Handler]:
        def decorator(handler: Handler) -> Handler:
            self._custom_key_handlers[key] = handler
            return handler

        return decorator


type Handler = Callable[[Context], Result]
type Result = Iterator[Row] | None


class Context:
    def __init__(self):
        raw_retv = getenv("ROFI_RETV")
        self._retv: int | None = int(raw_retv) if raw_retv is not None else None
        self._info: str = getenv("ROFI_INFO", "")
        self._data: str = getenv("ROFI_DATA", "")
        self._text: str = sys.argv[1] if len(sys.argv) > 1 else ""

    @property
    def retv(self) -> int | None:
        return self._retv

    @property
    def text(self) -> str:
        return self._text

    @property
    def info(self) -> str:
        return self._info

    @property
    def data(self) -> str:
        return self._data


class Row:
    columns: tuple[str, ...]
    attrs: dict[str, str]

    def __init__(self, *columns: str, **attrs: str):
        self.columns = columns
        self.attrs = attrs


def print_option(name: str, value: str) -> None:
    print(f"\0{name.replace("_", "-")}\x1f{value}")


def print_rows(rows: list[Row]) -> None:
    column_widths = defaultdict[int, int](int)
    for row in rows:
        for index, column in enumerate(row.columns):
            column_widths[index] = max(column_widths[index], len(column))

    for row in rows:
        text = ""
        for index, column in enumerate(row.columns):
            text += column.ljust(column_widths[index])
            if index < len(row.columns) - 1:
                text += "\t"

        attrs = [
            f"{name.replace('_', '-')}\x1f{value}"
            for (name, value) in row.attrs.items()
        ]
        print(f"{text}\0{'\x1f'.join(attrs)}")
