import 'dart:convert';

import 'package:background_fetch/background_fetch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:semester_5_project_mobile_app/services/notification.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

const EVENTS_KEY = "current_longLat_push";

void backgroundFetchHeadlessTask(String taskId) async {
  print("[BackgroundFetch] Headless event received: $taskId");
  await _saveLocation();
  BackgroundFetch.finish(taskId);
}

Future<void> initBackgroundTask() async {
  // Configure BackgroundFetch.
  BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            forceAlarmManager: false,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY,
          ),
          _onBackgroundFetch)
      .then((int status) {
    print('[BackgroundFetch] configure success: $status');
  }).catchError((e) {
    print('[BackgroundFetch] configure ERROR: $e');
  });
}

void _onBackgroundFetch(String taskId) async {
  await _saveLocation();
  BackgroundFetch.finish(taskId);
}

Future<void> _saveLocation() async {
  List<String> _events = [];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('token') && prefs.containsKey('fcm_token_push')) {
    String json = prefs.getString(EVENTS_KEY);
    if (json != null) {
      _events = jsonDecode(json).cast<String>();
    }

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    if (_events.length == 2) {
      _events.removeLast();
    }
    _events.insert(0, "$position");

    prefs.setString(EVENTS_KEY, jsonEncode(_events));

    var currLocationList = _events[0].split(', ');
    var currLocation = [
      currLocationList[0].substring(5),
      currLocationList[1].substring(6)
    ];

    var prevLocation;

    if (_events.length == 2) {
      var prevLocationList = _events[1].split(', ');
      prevLocation = [
        prevLocationList[0].substring(5),
        prevLocationList[1].substring(6)
      ];
    }

    var res = {
      'prev_location': prevLocation,
      'curr_location': currLocation,
      'FCM_token': prefs.getString('fcm_token_push')
    };
    bool result = await ApiRequestHandler.updateLocation(
        data: res, token: prefs.getString('token'));
    if (result) {
      NotificationService.showNotification('Commhawk', 'Location updated!');
    } else {
      NotificationService.showNotification(
          'Commhawk', 'Location update failed!');
    }
  } else {
    NotificationService.showNotification(
        'Commhawk', 'To use commhawk services, Please sign in again.');
  }
}
