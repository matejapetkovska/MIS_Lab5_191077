import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  Future initialise() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message contained a notification: ${message.notification}');
    }
  });
  }
}


