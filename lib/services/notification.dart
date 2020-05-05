import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/models/notification_data.dart';

class NotificationService {
  FirebaseMessaging _fcm;
  FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService() {
    _initFlnp();
    _initFcm();
  }

  void _initFcm() {
    _fcm = new FirebaseMessaging();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final NotificationData data =
            NotificationData.fromJson(message['data']);
        _onNotification(data);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _fcm.getToken().then((val) => print(val));
  }

  void _initFlnp() {
    _notificationsPlugin = new FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    IOSInitializationSettings initIOS = new IOSInitializationSettings();

    InitializationSettings initSettings =
        new InitializationSettings(initAndroid, initIOS);
    _notificationsPlugin = new FlutterLocalNotificationsPlugin();

    _notificationsPlugin.initialize(initSettings);
  }

  _onNotification(NotificationData data) {
    final Distance distance = new Distance();
    if (distance.as(LengthUnit.Kilometer, data.center, data.center) <=
        data.radius) {
      //show notification
      _showNotification(data.title, data.description);
    }
  }

  _showNotification(String title, String description) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _notificationsPlugin.show(
      0,
      title,
      description,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
