pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	property bool open: false
	property int viewedYear: clock.date.getFullYear()
	property int viewedMonth: clock.date.getMonth()
	readonly property int currentYear: clock.date.getFullYear()
	readonly property int currentMonth: clock.date.getMonth()
	readonly property int currentDay: clock.date.getDate()

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

	function show(): void {
		resetToToday()
		root.open = true
	}

	function hide(): void {
		root.open = false
	}

	function toggle(): void {
		if (root.open)
			hide()
		else
			show()
	}

	function resetToToday(): void {
		root.viewedYear = root.currentYear
		root.viewedMonth = root.currentMonth
	}

	function shiftMonth(amount: int): void {
		const date = new Date(root.viewedYear, root.viewedMonth + amount, 1)
		root.viewedYear = date.getFullYear()
		root.viewedMonth = date.getMonth()
	}

	function shiftYear(amount: int): void {
		root.viewedYear += amount
	}

	function previousMonth(): void {
		shiftMonth(-1)
	}

	function nextMonth(): void {
		shiftMonth(1)
	}

	function previousYear(): void {
		shiftYear(-1)
	}

	function nextYear(): void {
		shiftYear(1)
	}

	function isToday(year: int, month: int, day: int): bool {
		return year === root.currentYear
			&& month === root.currentMonth
			&& day === root.currentDay
	}

	function daysForViewedMonth(): var {
		// JavaScript getDay() starts on Sunday; the calendar starts on Monday.
		const first = new Date(root.viewedYear, root.viewedMonth, 1)
		const leadingDays = (first.getDay() + 6) % 7
		const start = new Date(root.viewedYear, root.viewedMonth, 1 - leadingDays)
		const days = []

		for (let index = 0; index < 42; index++) {
			const date = new Date(start.getFullYear(), start.getMonth(), start.getDate() + index)
			days.push({
				day: date.getDate(),
				month: date.getMonth(),
				year: date.getFullYear(),
				currentMonth: date.getMonth() === root.viewedMonth && date.getFullYear() === root.viewedYear,
				today: root.isToday(date.getFullYear(), date.getMonth(), date.getDate()),
			})
		}

		return days
	}
}
