// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late TableCalendar _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2023, 1, 1),
      lastDay: DateTime(2025, 12, 31),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Page'),
      ),
      body: TableCalendar(
        calendarFormat: _calendarController.calendarFormat,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.yellowAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.black),
          markersMaxCount: 5,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        focusedDay: DateTime.now(),
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2025, 12, 31),
      ),
    );
  }
}
