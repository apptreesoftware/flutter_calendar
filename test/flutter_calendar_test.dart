import 'package:flutter_calendar/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateUtil Tests', () {
    List<DateTime> testDates = [];
    DateTime today;

    setUp(() {
      today = new DateTime.now();
      // A full Calendar Week
      testDates
        ..add(new DateTime(2018, 3, 4))
        ..add(new DateTime(2018, 3, 5))
        ..add(new DateTime(2018, 3, 6))
        ..add(new DateTime(2018, 3, 7))
        ..add(new DateTime(2018, 3, 8))
        ..add(new DateTime(2018, 3, 9))
        ..add(new DateTime(2018, 3, 10));
    });

    for (var i = 0; i < 7; i++) {
      test('Utils.firstDayOfWeek', () {
        expect(Utils.firstDayOfWeek(testDates[i]).day, testDates[0].day);
      });
    }

    // Test 100 Days
    for (var i = 0; i < 100; i++) {
      test('datesInRange()', () {
        var date = new DateTime.now();
        date.add(new Duration(days: i));

        var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
        var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);

        expect(
            Utils
                .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList()
                .length,
            7);
      });
    }
  });
}
