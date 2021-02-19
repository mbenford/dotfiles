from libqtile import layout
from libqtile.log_utils import logger


class Columns(layout.Columns):
    def __init__(self, **config):
        layout.Columns.__init__(self, **config)

    def swap(self, src, dst):
        self.columns[src], self.columns[dst] = self.columns[dst], self.columns[src]
        self.current = dst
        self.group.layout_all()

    def cmd_swap_left(self):
        src = self.current
        dst = src - 1 if src > 0 else len(self.columns) - 1
        self.swap(src, dst)

    def cmd_swap_right(self):
        src = self.current
        dst = src + 1 if src < len(self.columns) - 1 else 0
        self.swap(src, dst)

