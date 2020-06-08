import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/models/alert_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService extends ChangeNotifier {
  static FlutterLocalNotificationsPlugin notificationsPlugin;

  NotificationService() {
    initFlnp();
  }
  // static Future<void> initFcm() async {
  //   print('init firebase messaging');
  //   final fcm = new FirebaseMessaging();
  //   fcm.configure(
  //     // onBackgroundMessage: onBackground,
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('---onMessage: $message');
  //       onNotification(AlertMessage.fromJson(message));
  //       print('---next');
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       await onNotification(AlertMessage.fromJson(message));
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       await onNotification(AlertMessage.fromJson(message));
  //     },
  //   );
  //   String token = await fcm.getToken();
  //   print('fcm-token: $token');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('fcm_token_push', token);
  //   Firestore.instance.collection('users').document(token).setData({});
  // }

  Future<void> initFCM() async {
    FirebaseMessaging fcm = new FirebaseMessaging();
    fcm.configure(
      onMessage: (Map<String, dynamic> message) {
        print('--onMessage: $message');
        Map<String, dynamic> data = Map<String, dynamic>.from(message["data"]);
        onNotification(AlertMessage.fromJson(data));
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('--onLaunch: $message');
        Map<String, dynamic> data = Map<String, dynamic>.from(message["data"]);
        onNotification(AlertMessage.fromJson(data));
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('--onResume: $message');
        Map<String, dynamic> data = Map<String, dynamic>.from(message["data"]);
        onNotification(AlertMessage.fromJson(data));
        return;
      },
      // onBackgroundMessage: onBackground,
    );
    String token = await fcm.getToken();
    print('fcm-token: $token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token_push', token);
    Firestore.instance.collection('users').document(token).setData({});
  }

  Future<void> onNotification(AlertMessage message) async {
    print('--alert received: $message');
    bool ok = true;
    if (message.radius != null) {
      final distance = new Distance();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('--location: $position');
      double meters = distance.as(
          LengthUnit.Meter,
          message.center,
          LatLng(
            position.latitude,
            position.longitude,
          ));
      print('--distance: $meters');
      if (meters > message.radius) {
        ok = false;
        print('--outside radius');
        //show notification
        // await showNotification(message.title, message.description);
      } else {
        print('--inside radius');
      }
    }
    if (ok) {
      print('--savenotification');
      await saveAlert(message);
      print('--shownotification');
      await showNotification(message.title, message.description);
      notifyListeners();
    }
  }

  Future<void> saveAlert(AlertMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alerts = [];
    try {
      alerts = prefs.getStringList('alerts') ?? [];
    } catch (err) {
      print('no alerts - $err');
    }
    alerts.add(jsonEncode(message.toJson()));
    prefs.setStringList('alerts', alerts);
  }

  Future<bool> initFlnp() async {
    print('init local notifications');
    notificationsPlugin = new FlutterLocalNotificationsPlugin();

    final initAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    final initIOS = new IOSInitializationSettings();

    final initSettings = new InitializationSettings(initAndroid, initIOS);
    notificationsPlugin = new FlutterLocalNotificationsPlugin();

    return await notificationsPlugin.initialize(initSettings);
  }

  // Future<void> onBackground(Map<String, dynamic> message) {
  //   print('--onResume: $message');
  //   Map<String, dynamic> data = Map<String, dynamic>.from(message["data"]);
  //   onNotification(AlertMessage.fromJson(data));
  // }

  static Future<void> showNotification(String title, String description) async {
    if (notificationsPlugin != null) {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'commhawk_notification_channel_id',
        'Commhawk',
        'Disaster management system',
        importance: Importance.Max,
        priority: Priority.High,
      );
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await notificationsPlugin.show(
        0,
        title,
        description,
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    } else {
      print('--notification-plugin: falied');
    }
  }
}
