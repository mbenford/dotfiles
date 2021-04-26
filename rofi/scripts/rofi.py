from os import getenv


class Rofi:
    def __init__(self):
        self.__retv = getenv("ROFI_RETV")

        info = getenv("ROFI_INFO", "")
        self.__info = [] if info == "" else info.split(";")


    def row(self, text, meta=None, info=None):
        opts = []
        opt_fmt = "{name}\x1f{value}"

        if meta is not None:
            opts.append(opt_fmt.format(name="meta", value=meta))

        if info is not None:
            opts.append(opt_fmt.format(name="info",
                                       value=";".join([*self.__info, str(info)])))

        opts = "\x1f".join(opts)
        print(f"{text}\0{opts}")


    def info(self, index=None):
        return self.__info if index is None else self.__info[index]


    def retv(self):
        return None if self.__retv is None else int(self.__retv)


    def prompt(self, text):
        self.__set_option("prompt", text)


    def message(self, text):
        self.__set_option("message", text)


    def markup_rows(self, enabled):
        self.__set_option("markup-rows", str(enabled).lower())


    def custom_entry(self, enabled):
        self.__set_option("no-custom", str(enabled).lower())


    def __set_option(self, name, value):
        print(f"\0{name}\x1f{value}")


