import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final List<String> events;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.events: null,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: onDateSelected,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(204, 204, 204, 0.3),
                )
              : BoxDecoration(),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Utils.formatDay(date).toString(),
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              ),
              events != null && events.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: events
                          .map((event) => Container(
                                margin: EdgeInsets.only(
                                    left: 2.0, right: 2.0, top: 2.0),
                                width: 4.0,
                                height: 4.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      const Color.fromRGBO(247, 64, 106, 1.0),
                                ),
                              ))
                          .toList())
                  : Container(),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
