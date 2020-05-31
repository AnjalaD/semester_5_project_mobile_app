import 'dart:async';

import 'package:flutter/widgets.dart';

class Messages extends ChangeNotifier {
  String _message;

  String get message => _message;

  void add(String text) {
    _message = text;
    notifyListeners();
    Timer(Duration(seconds: 10), () {
      _message = null;
      notifyListeners();
    });
  }

  void close() {
    _message = null;
    notifyListeners();
  }
}
