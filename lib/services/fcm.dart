import 'package:firebase_messaging/firebase_messaging.dart';

class Fcm {
  FirebaseMessaging _fcm = FirebaseMessaging();
  Fcm() {
    init();
  }

  void init() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
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
}
