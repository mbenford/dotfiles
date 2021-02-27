import os


def get_displays():
    displays = os.popen(
        "xrandr | grep -E '\sconnected\s(primary|[0-9])'"
    ).read()[:-1].split("\n")
    return len(displays)


def exec_first(instance, *methods):
    for method in methods:
        func = getattr(instance, method, None)
        if not callable(func):
            continue

        func()
        return
