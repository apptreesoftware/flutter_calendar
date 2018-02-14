import 'package:flutter/material.dart';
import 'package:flutter_calendar/calendar.dart';

main() {
  runApp(new CalendarViewApp());
}

class CalendarViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('A Calendar?'),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new Calendar(),
        ),
      ),
    );
  }
}
