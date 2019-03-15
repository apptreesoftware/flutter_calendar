import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
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
      return new InkWell(
        onTap: onDateSelected,
        child: new Container(
          decoration: isSelected
              ? new BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(204, 204, 204, 0.3),
                )
              : new BoxDecoration(),
          alignment: Alignment.center,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  Utils.formatDay(date).toString(),
                  style: new TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
                Utils.fullDayFormat(date).toString() == Utils.fullDayFormat(DateTime.now()).toString()
                    ? new Container(
                        padding: new EdgeInsets.only(top: 3.0),
                        width: 3.0,
                        height: 3.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(247, 64, 106,1.0), // cor da marcacao do dia de hoje
                        ),
                      )
                    : new Container()
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
