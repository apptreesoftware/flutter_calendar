library utils;

import "package:intl/intl.dart";

class Utils {
  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
  static final DateFormat _dayFormat = new DateFormat("dd");
  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
  static final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");

  static String formatMonth(DateTime d) => _monthFormat.format(d);
  static String formatDay(DateTime d) => _dayFormat.format(d);
  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

  static const List<String> weekdays = const [
    "S",
    "M",
    "T",
    "W",
    "T",
    "F",
    "S"
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(new Duration(days: daysBefore));
    var last = Utils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;
    var lastToDisplay = last.add(new Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return new DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    day = day.add(new Duration(hours: 12));
    var decreaseNum = day.weekday % 7;
    return day.subtract(new Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    var increaseNum = day.weekday % 7;
    return day.add(new Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? new DateTime(month.year, month.month + 1, 1)
        : new DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(new Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(new Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    var diff = a.difference(b).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return new DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return new DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(new Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(new Duration(days: 7));
  }
}
