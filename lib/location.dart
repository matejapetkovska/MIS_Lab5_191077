import './models/classrooms.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  Position _currentUserPosition;
  double distanceImMeter = 0.0;
  Data data = Data();
  int smallestRoute = 99999999;

  Future _getTheDistance() async {

bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    // Location service is not enabled on the device
    return;
  }

  // Request permission to access the location
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // The user denied permission or did not grant it permanently
      return;
    }
  }

  // Permission has been granted, get the current position
  _currentUserPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);


    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(_currentUserPosition);

    
    for (int i = 0; i < data.classrooms.length; i++) {
      double Lablat = data.classrooms[i]['lat'];
      double Lablng = data.classrooms[i]['lng'];

      double distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition.latitude,
        _currentUserPosition.longitude,
        Lablat,
        Lablng,
      );
      var distance = distanceImMeter.round().toInt();

      data.classrooms[i]['distance'] = (distance / 100);
      if ((distance / 100).round() < smallestRoute) {
        smallestRoute = (distance / 100).round();
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text("Classrooms for exams"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: GridView.builder(
            itemCount: data.classrooms.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.pink,
                height: height * 0.9,
                width: width * 0.3,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.12,
                      width: width,
                      child: Image.network(
                        data.classrooms[index]['image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      data.classrooms[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          "${data.classrooms[index]['distance'].round()} KM Away",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
        "Smallest route: $smallestRoute km",
         textAlign: TextAlign.center,
         style: TextStyle(
         fontSize: 20,
         fontWeight: FontWeight.bold,
          ),
        ),
        height: 60,
      ),
    );
  }
}
