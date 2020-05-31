import 'dart:convert';

import 'package:background_fetch/background_fetch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

const EVENTS_KEY = "current_longLat_push";

void backgroundFetchHeadlessTask(String taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
  print("[BackgroundFetch] Headless event received: $taskId");
  String tokenGet = prefs.getString('fcm_token_push');
  print(tokenGet);

  List<String> events = [];
  String json = prefs.getString(EVENTS_KEY);
  if (json != null) {
    events = jsonDecode(json).cast<String>();
  }
  if (events.length == 2) {
    events.removeLast();
  }
  events.insert(0, "$position");
  prefs.setString(EVENTS_KEY, jsonEncode(events));

  var currLocationList = events[0].split(', ');
  var currLocation = [
    currLocationList[0].substring(5),
    currLocationList[1].substring(6)
  ];
  var prevLocation;
  if (events.length == 2) {
    var prevLocationList = events[1].split(', ');
    prevLocation = [
      prevLocationList[0].substring(5),
      prevLocationList[1].substring(6)
    ];
  }

  var res = {
    'prev_location': prevLocation,
    'curr_location': currLocation,
    'FCM_token': tokenGet
  };
  print(res);
  BackgroundFetch.finish(taskId);
}

Future<Map<String, dynamic>> _saveLocation() async {
  List<String> _events = [];

  SharedPreferences prefs = await SharedPreferences.getInstance();
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
  //print(_events);
  String _fcmToken = prefs.getString('fcm_token_push');
  print(_fcmToken);
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
    'FCM_token': _fcmToken
  };
  //send to server
  return res;
}

Future<void> initBackgroundTask() async {
  // Load persisted fetch events from SharedPreferences
  var l = await _saveLocation();
  print(l);
  //send to server

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
            requiredNetworkType: NetworkType.NONE,
          ),
          _onBackgroundFetch)
      .then((int status) {
    print('[BackgroundFetch] configure success: $status');
  }).catchError((e) {
    print('[BackgroundFetch] configure ERROR: $e');
  });
}

void _onBackgroundFetch(String taskId) async {
  var l = await _saveLocation();
  print(l);
  BackgroundFetch.finish(taskId);
}
