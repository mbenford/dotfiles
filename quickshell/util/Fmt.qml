pragma Singleton

import Quickshell
import QtQuick

Singleton {
	function duration(totalSeconds: int, opts: var): string {
		const o = Object.assign({ compact: false, totalSeconds: true, maxUnits: 0 }, opts || {});

		const total = Math.max(0, Math.floor(totalSeconds));
		const h = Math.floor(total / 3600);
		const m = Math.floor((total % 3600) / 60);
		const s = total % 60;

		const fmt = (n, short, long) => o.compact ? n + short : n + " " + long + (n === 1 ? "" : "s");

		let parts = [];
		if (h > 0) parts.push(fmt(h, "h", "hour"));
		if (m > 0) parts.push(fmt(m, "m", "minute"));
		if (o.totalSeconds && s > 0) parts.push(fmt(s, "s", "second"));

		if (parts.length === 0) parts.push(o.totalSeconds ? fmt(0, "s", "second") : fmt(0, "m", "minute"));
		if (o.maxUnits > 0) parts = parts.slice(0, o.maxUnits);

		return parts.join(o.compact ? " " : ", ");
	}
}
