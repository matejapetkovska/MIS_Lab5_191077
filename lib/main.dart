import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import './auth_screen.dart';
import 'examList.dart';
import 'auth.dart';
import 'location.dart';
import 'newExam.dart';
import '../models/course.dart';
import 'calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Exam App',
        theme: ThemeData(
            primarySwatch: Colors.pink),
        home: AuthScreen(),
        routes: {'/courses': ((context) => MyHomePage())},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Course> _courseList = [
    Course(
        name: 'Mobilni informaciski sistemi',
        date: DateTime.now(),
        id: DateTime.now().toString(),
        time: '12:45'),
    Course(
        name: 'Bazi na podatoci',
        date: DateTime.now(),
        id: DateTime.now().toString(),
        time: '08:00'),
    Course(
        name: 'Verojatnost i statistika',
        date: DateTime.now(),
        id: DateTime.now().toString(),
        time: '17:30'),
  ];

  void _startAddingNewExam(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(onTap: () {}, child: NewExam(_addNewExam));
      },
    );
  }

  void _addNewExam(String name, DateTime date, String time) {
    var url = Uri.https(
      'studentorganizer-10243-default-rtdb.firebaseio.com',
      '/courses.json',
    );

    http.post(url,
        body: json.encode({
          'title': name,
          'date': date.toString(),
          'time': time,
        }));
    setState(() {
      _courseList
          .add(Course(name: name, date: date, id: DateTime.now().toString(), time:time));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Exam App'),
          actions: [
            IconButton(
                onPressed: () => _startAddingNewExam(context),
                icon: Icon(Icons.add)),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LocationService()));
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(_courseList),
                  ),
                );
              },
              icon: Icon(Icons.calendar_month_rounded),
            ),
          ],
        ),
        body: Container(
          child: Column(children: [
            Container(child: ExamList(_courseList)),
          ]),
        ),
      ),
    );
  }
}
