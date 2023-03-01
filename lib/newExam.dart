import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExam extends StatefulWidget {
  final Function _addNewExam;
  NewExam(this._addNewExam);

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  var _titleController = TextEditingController();
  DateTime date;
  var _timeController = TextEditingController();

  void _submitData() {
    var _title = _titleController.text;
    var _time = _timeController.text;
    if (_title == null || date == null || _time == null) {
      return;
    }
    widget._addNewExam(_title, date, _time);
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((value) {
      date = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        elevation: 5,
        child: TextField(
          controller: _titleController,
          decoration: InputDecoration(label: Text('Course exam name')),
        ),
      ),
      Card(
        elevation: 5,
        child: Row(
          children: [
            TextButton(
                onPressed: _showDatePicker,
                child: Text('Course exam date')),
            date == null
              ? Text('Choose a date!')
              : Text(DateFormat.yMMMMd().format(date)),
          ],
        ),
      ),
      Card(
        elevation: 5,
        child: TextField(
          controller: _timeController,
          decoration: InputDecoration(label: Text('Course exam time')),
        ),
      ),
      ElevatedButton(onPressed: _submitData, child: Text('Enter'))
    ]);
  }
}
