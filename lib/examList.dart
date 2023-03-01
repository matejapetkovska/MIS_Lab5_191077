import 'package:flutter/material.dart';
import './models/course.dart';
import 'package:intl/intl.dart';

class ExamList extends StatelessWidget {
  final List<Course> _list;

  ExamList(this._list);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _list.map((course) {
      return Card(
        elevation: 10,
        child: Container(
          height: 80,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(
                  course.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  DateFormat.yMMMMd().format(course.date),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  course.time,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
