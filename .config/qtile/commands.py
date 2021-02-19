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

    def to_inactive_group(self):
        def cmd(qtile):
            for g in qtile.groups:
                if len(g.windows) == 0:
                    qtile.current_window.togroup(g.name)
                    return

        return lazy.function(cmd)


