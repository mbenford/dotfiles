from libqtile import widget, bar, pangocffi
from libqtile.widget import base

import time
import psutil


class Uptime(base.ThreadPoolText):
    defaults = [
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(Uptime.defaults)

    def get_uptime(self):
        seconds = time.time() - psutil.boot_time()

        days, seconds = divmod(seconds, 86400)
        if days > 0:
            return f"{days:.0f}d"

        hours, seconds = divmod(seconds, 3600)
        if hours > 0:
            return f"{hours:.0f}h"

        minutes, seconds = divmod(seconds, 60)
        return f"{minutes:.0f}m"

    def poll(self):
        return self.get_uptime()


class VPN(base.ThreadPoolText):
    defaults = [
        ("interface", "tun0", ""),
        ("active_text", "on", ""),
        ("inactive_text", "off", ""),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(VPN.defaults)

    def poll(self):
        return self.active_text if self.interface in psutil.net_if_addrs() else self.inactive_text


class WindowName(widget.WindowName):
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ('max_chars', 0, 'max chars before truncating with ellipis'),
    ]

    def __init__(self, width=bar.STRETCH, **config):
        widget.WindowName.__init__(self, width=width, **config)
        self.add_defaults(WindowName.defaults)

    def truncate(self, text):
        if self.max_chars == 0:
            return text

        return (text[:self.max_chars - 3].rstrip() + "...") if len(text) > self.max_chars else text

    @widget.WindowName.text.setter
    def text(self, value):
        super(WindowName, type(self)).text.fset(self, self.truncate(value))


class SensorTemp(base.ThreadPoolText):
    defaults = [
        ("sensor", "coretemp", ""),
        ("label", "Package id 0", ""),
        ("format", "{current:.0f}°C", ""),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(SensorTemp.defaults)

    def poll(self):
        sensor = psutil.sensors_temperatures().get(self.sensor)
        if sensor is None:
            return "N/A"

        value = next((temp for temp in sensor if temp.label == self.label), None)
        if value is None:
            return "N/A"

        return self.format.format(current=value.current)


class SensorFan(base.ThreadPoolText):
    defaults = [
        ("sensor", "dell_smm", ""),
        ("label", "", ""),
        ("format", "{current}", ""),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(SensorFan.defaults)

    def poll(self):
        sensor = psutil.sensors_fans().get(self.sensor)
        if sensor is None:
            return "N/A"

        value = next((temp for temp in sensor if temp.label == self.label), None)
        if value is None:
            return "N/A"

        return self.format.format(current=value.current)
