class Course {
  String id;
  String name;
  DateTime date;
  String time;


  Course({this.id, this.name, this.date, this.time});

  String getName() {
    return name;
  }

  DateTime getDate() {
    return date;
  }

  String getTime() {
    return time;
  }
  
}
