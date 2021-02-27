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


class ThreeColumns(layout.Columns):
    defaults = [
        ("main_size", 50, "")
    ]
    def __init__(self, **config):
        layout.Columns.__init__(self, **config)
        self.add_defaults(ThreeColumns.defaults)
        self.num_columns = 3
        # self.margin_on_single = 200
        self.client_count = 0

    def add(self, client):
        super().add(client)

        if len(self.columns) == 3:
            main_width = 300 * self.main_size / 100
            other_width = (300 - main_width) / 2
            self.columns[0].width = other_width
            self.columns[1].width = main_width
            self.columns[2].width = other_width
            self.group.layout_all()

    def remove(self, client):
        super().remove(client)

        if 0 < len(self.columns) < 3:
            for col in self.columns:
                col.width = 100
            self.group.layout_all()

    def add_column(self):
        if len(self.columns) < 2:
            return super().add_column(True)
        elif len(self.columns) == 2:
            return super().add_column(False)
