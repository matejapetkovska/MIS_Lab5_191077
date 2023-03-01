import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/course.dart';

class Calendar extends StatelessWidget {
  List<Course> _courseList;
  Calendar(this._courseList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar of exams")),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource(_courseList)),
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            navigationDirection: MonthNavigationDirection.horizontal),
        todayHighlightColor: Colors.tealAccent,
        showNavigationArrow: true,
      ),
    );
  }
}

List<Meeting> _getDataSource(_courseList) {
  final List<Meeting> meetings = <Meeting>[];
  _courseList.forEach((element) {
    final DateTime startTime = DateTime(
        element.date.year, element.date.month, element.date.day, 9, 15);
    final DateTime endTime = startTime.add(const Duration(hours: 3, minutes: 15));
    meetings.add(
        Meeting(element.name, startTime, endTime, Colors.pinkAccent));
  });
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}
