from abc import abstractmethod

from libqtile import widget, bar, hook
from libqtile.log_utils import logger
from libqtile.widget import base

import time
import psutil

from dbus_next.glib import MessageBus
from dbus_next.message import Message
from dbus_next.constants import BusType


class Uptime(base.ThreadPoolText):
    defaults = [
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(Uptime.defaults)

    def poll(self):
        seconds = time.time() - psutil.boot_time()

        days, seconds = divmod(seconds, 86400)
        if days > 0:
            return f"{days:.0f}d"

        hours, seconds = divmod(seconds, 3600)
        if hours > 0:
            return f"{hours:.0f}h"

        minutes, seconds = divmod(seconds, 60)
        return f"{minutes:.0f}m"


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
    def __init__(self, width=bar.STRETCH, **config):
        widget.WindowName.__init__(self, width=width, **config)
        self.add_defaults(WindowName.defaults)

    def update(self, *args):
        if self.for_current_screen:
            w = self.qtile.current_screen.group.current_window
        else:
            w = self.bar.screen.group.current_window

        if w:
            wm_class = w.window.get_wm_class()
            params = dict(
                name=self.truncate(w.name),
                wm_class=wm_class[0] if len(wm_class) > 0 else ""
            )
            self.text = self.format.format(**params)
        else:
            self.text = self.empty_group_string

        self.bar.draw()

class BaseMonitor(base.ThreadPoolText):
    defaults = [
        ("warning_threshold", None, ""),
        ("warning_foreground", "#d1a966", ""),
        ("critical_threshold", None, ""),
        ("critical_foreground", "#ef596f", ""),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(BaseMonitor.defaults)

    def highlight_value(self, value):
        text = self.format.format(value=value)

        if self.critical_threshold is not None and value > self.critical_threshold:
            return f"<span foreground='{self.critical_foreground}'>{text}</span>"

        if self.warning_threshold is not None and value > self.warning_threshold:
            return f"<span foreground='{self.warning_foreground}'>{text}</span>"

        return text

    def poll(self):
        value = self.run()
        if value is None:
            return "N/A"

        return self.highlight_value(value)

    @abstractmethod
    def run(self):
        pass


class SensorTemp(BaseMonitor):
    defaults = [
        ("sensor", "coretemp", ""),
        ("label", "Package id 0", ""),
        ("format", "{value:.0f}°C", ""),
    ]

    def __init__(self, **config):
        BaseMonitor.__init__(self, **config)
        self.add_defaults(SensorTemp.defaults)

    def run(self):
        sensor = psutil.sensors_temperatures().get(self.sensor)
        if sensor is None:
            return None

        value = next((temp for temp in sensor if temp.label == self.label), None)
        if value is None:
            return None

        return value.current


class SensorFan(BaseMonitor):
    defaults = [
        ("sensor", "dell_smm", ""),
        ("label", "", ""),
        ("format", "{value}", ""),
    ]

    def __init__(self, **config):
        BaseMonitor.__init__(self, **config)
        self.add_defaults(SensorFan.defaults)

    def run(self):
        sensor = psutil.sensors_fans().get(self.sensor)
        if sensor is None:
            return None

        value = next((temp for temp in sensor if temp.label == self.label), None)
        if value is None:
            return None

        return value.current

class ChordStatus(base._TextBox):
    defaults = []

    def __init__(self, width=bar.CALCULATED, **config):
        base._TextBox.__init__(self, "", width, **config)
        self.add_defaults(ChordStatus.defaults)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        self.text = self.inactive_text
        self.foreground = self.inactive_color
        self._setup_hooks()

    def _setup_hooks(self):
        def enter_chord(name):
            self.text = self.active_text
            self.foreground = self.active_color
            self.bar.draw()

        def leave_chord(*args):
            self.text = self.inactive_text
            self.foreground = self.inactive_color
            self.bar.draw()

        hook.subscribe.enter_chord(enter_chord)
        hook.subscribe.leave_chord(leave_chord)


class PowerManagementStatus(base.ThreadPoolText):
    defaults = [
        ("on_text", "on", ""),
        ("off_text", "off", ""),
        ("off_foreground", "#ff0000", ""),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(PowerManagementStatus.defaults)
        self.bus = MessageBus(bus_type=BusType.SESSION).connect_sync()

    def poll(self):
        reply = self.bus.call_sync(Message(
            destination="org.freedesktop.PowerManagement",
            path="/org/freedesktop/PowerManagement/Inhibit",
            interface="org.freedesktop.PowerManagement.Inhibit",
            member="GetInhibitors",
        ))

        body = reply.body
        inhibitors = body[0] if body is not None and len(body) > 0 else []
        if len(inhibitors) > 0:
            return f"<span foreground='{self.off_foreground}'>{self.off_text}</span>"

        return self.on_text
