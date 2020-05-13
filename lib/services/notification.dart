import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/models/notification_data.dart';

class NotificationService {
  FirebaseMessaging _fcm;
  static FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService() {
    _initFlnp();
    _initFcm();
  }

  void _initFcm() {
    print('init firebase messaging');
    _fcm = new FirebaseMessaging();
    _fcm.configure(
      onBackgroundMessage: onBackground,
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _onNotification(new NotificationData.fromJson(message['data']));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _onNotification(new NotificationData.fromJson(message['data']));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _onNotification(new NotificationData.fromJson(message['data']));
      },
    );
    _fcm.getToken().then((val) => print(val));
  }

  void _initFlnp() {
    print('init local notifications');
    _notificationsPlugin = new FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    IOSInitializationSettings initIOS = new IOSInitializationSettings();

    InitializationSettings initSettings =
        new InitializationSettings(initAndroid, initIOS);
    _notificationsPlugin = new FlutterLocalNotificationsPlugin();

    _notificationsPlugin.initialize(initSettings);
  }

  static Future<void> _onNotification(NotificationData data) async {
    print('onNotification');
    final Distance distance = new Distance();
    print(
        distance.as(LengthUnit.Kilometer, data.center, data.center).toString());

    if (distance.as(LengthUnit.Kilometer, data.center, data.center) <=
        data.radius) {
      //show notification
      await _showNotification(data.title, data.description);
    }
  }

  static Future<void> _showNotification(
      String title, String description) async {
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

  static Future<dynamic> onBackground(Map<String, dynamic> message) async {
    _showNotification('afsaf', 'sfafasfsaf');
    print('onMessage: $message');
    _onNotification(new NotificationData.fromJson(message['data']));
  }
}
