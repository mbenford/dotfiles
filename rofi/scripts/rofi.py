import argparse
from abc import ABC, abstractmethod
from os import getenv


class RofiScript(ABC):
    def __init__(self):
        info = getenv("ROFI_INFO", "")
        self.__info = [] if info == "" else info.split(";")
        self.__retv = getenv("ROFI_RETV")

    def run(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('selected', nargs='?', default='')
        args, rest = parser.parse_known_args()

        if args.selected == '':
            self.generate(args=rest)
        else:
            self.execute(selected=args.selected, args=rest)

    @abstractmethod
    def generate(self, args):
        pass

    @abstractmethod
    def execute(self, selected, args):
        pass

    def row(self, text, icon=None, meta=None, info=None, selectable=True):
        opts = []
        opt_fmt = "{name}\x1f{value}"

        if icon is not None:
            opts.append(opt_fmt.format(name="icon", value=icon))

        if meta is not None:
            opts.append(opt_fmt.format(name="meta", value=meta))

        if info is not None:
            opts.append(opt_fmt.format(name="info",
                                       value=";".join([*self.__info, str(info)])))

        if not selectable:
            opts.append(opt_fmt.format(name="nonselectable", value="true"))

        opts = "\x1f".join(opts)
        print(f"{text}\0{opts}")
        return self

    def info(self, index=None):
        if index is None:
            return self.__info
        return self.__info[index] if index < len(self.__info) else None

    def retv(self):
        return None if self.__retv is None else int(self.__retv)

    def prompt(self, text):
        self.__set_option("prompt", text)
        return self

    def message(self, text):
        self.__set_option("message", text)
        return self

    def markup_rows(self, enabled):
        self.__set_option("markup-rows", str(enabled).lower())
        return self

    def custom_entry(self, enabled):
        self.__set_option("no-custom", str(enabled).lower())
        return self

    def hotkeys(self, enabled):
        self.__set_option("use-hot-keys", str(enabled).lower())
        return self

    @staticmethod
    def __set_option(name, value):
        print(f"\0{name}\x1f{value}")
