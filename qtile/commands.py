from libqtile.lazy import lazy
import util


class WindowCommands:
    def __init__(self):
        self.maximized_groups = dict()

    def toggle_maximized(self, layout):
        def cmd(qtile):
            curr_group = qtile.current_group
            curr_layout = qtile.current_layout

            if curr_layout.name == layout:
                curr_group.cmd_setlayout(self.maximized_groups.pop(curr_group.name))
            else:
                if curr_group.name not in self.maximized_groups:
                    self.maximized_groups[curr_group.name] = curr_layout.name

                curr_group.cmd_setlayout(layout)

        return lazy.function(cmd)

    def to_empty_group(self, switch=True):
        def cmd(qtile):
            index = qtile.groups.index(qtile.current_group)
            visited = 0
            while visited < len(qtile.groups):
                index += 1
                if index >= len(qtile.groups):
                    index = 0

                group = qtile.groups[index]
                if len(group.windows) == 0:
                    qtile.current_window.togroup(group.name, switch_group=switch)
                    return

                visited += 1

        return lazy.function(cmd)

    def to_next_screen(self, focus=True):
        return self._to_screen(+1, focus)

    def to_prev_screen(self, focus=True):
        return self._to_screen(-1, focus)

    def _to_screen(self, offset, focus=True):
        def cmd(qtile):
            index = qtile.current_screen.index + offset
            if index >= len(qtile.screens):
                index = 0
            elif index < 0:
                index = len(qtile.screens) - 1

            curr_window = qtile.current_window
            if curr_window is not None:
                curr_window.toscreen(index=index)
                if focus:
                    qtile.focus_screen(index)

        return lazy.function(cmd)
