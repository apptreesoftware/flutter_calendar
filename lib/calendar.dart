import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/calendar_tile.dart';
import 'package:flutter_calendar/src/utils.dart';

class Calendar extends StatefulWidget {
  final VoidCallback onDateSelected;
  final TextStyle dateStyles;
  final TextStyle dayOfWeekStyles;
  final TextStyle outOfMonthDateStyles;
  final Border tileBorder;
  final bool isExpandable;

  Calendar({
    this.onDateSelected,
    this.dateStyles,
    this.dayOfWeekStyles,
    this.outOfMonthDateStyles,
    this.tileBorder,
    this.isExpandable: false,
  });

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = new Utils();
  DateTime today = new DateTime.now();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime selectedDate;
  bool isExpanded = false;

  void initState() {
    super.initState();
    selectedMonthsDays = Utils.daysInMonth(today);
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
    selectedWeeksDays =
        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek).toList();
    selectedDate = today;
  }

  Widget get monthNameRow {
    var leftIcon;
    var rightIcon;
    if (widget.isExpandable) {
      leftIcon = new IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: new Icon(Icons.chevron_left),
      );
      rightIcon = new IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: new Icon(Icons.chevron_right),
      );
    } else {
      leftIcon = new InkWell(
        child: new Text('Today'),
        onTap: resetToToday,
      );
      rightIcon = new IconButton(
        onPressed: () => selectDateFromPicker(),
        icon: new Icon(Icons.calendar_today),
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftIcon,
        new Text(
          Utils.formatMonth(today),
          style: new TextStyle(
            fontSize: 20.0,
          ),
        ),
        rightIcon
      ],
    );
  }

  Widget get calendarGridView {
    return new Container(
      child: new GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: new GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 1.5,
          children: calendarBuilder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[monthNameRow, calendarGridView],
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeeksDays;

    Utils.weekdays.forEach(
      (day) {
        dayWidgets.add(
          new CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
            dayOfWeekStyles: widget.dayOfWeekStyles,
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        dayWidgets.add(
          new CalendarTile(
            onDateSelected: () => handleSelectedDateAndUserCallback(day),
            date: day,
            dateStyles: (monthStarted && !monthEnded)
                ? widget.outOfMonthDateStyles
                : widget.dateStyles,
            tileBorder: widget.tileBorder,
            isSelected: Utils.isSameDay(selectedDate, day),
          ),
        );
      },
    );
    return dayWidgets;
  }

  void resetToToday() {
    today = new DateTime.now();
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
    setState(() {
      selectedDate = today;
      selectedWeeksDays = Utils
          .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
          .toList();
    });
  }

  void nextMonth() {
    setState(() {
      today = Utils.nextMonth(today);
      selectedMonthsDays = Utils.daysInMonth(today);
    });
  }

  void previousMonth() {
    setState(() {
      today = Utils.previousMonth(today);
      selectedMonthsDays = Utils.daysInMonth(today);
    });
  }

  void nextWeek() {
    setState(() {
      today = Utils.nextWeek(today);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
      selectedWeeksDays = Utils
          .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
          .toList();
    });
  }

  void previousWeek() {
    setState(() {
      today = Utils.previousWeek(today);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(today);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(today);
      selectedWeeksDays = Utils
          .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
          .toList();
    });
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: today ?? new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

    if (selectedDate != null) {
      setState(() {
        selectedDate = selected;
        selectedWeeksDays = Utils
            .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList();
      });
    }
  }

  var gestureStart;
  var gestureDirection;
  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (isExpanded) {
        nextMonth();
      } else {
        nextWeek();
      }
    } else {
      if (isExpanded) {
        previousMonth();
      } else {
        previousWeek();
      }
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
    setState(() {
      selectedDate = day;
      selectedWeeksDays = Utils
          .daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
          .toList();
    });
    widget.onDateSelected();
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      flex: 1,
      child: new AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
