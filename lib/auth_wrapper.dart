import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/views/alerts/alerts_list.dart';
import 'package:semester_5_project_mobile_app/views/auth/login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(builder: (context, auth, child) {
      print('auth: ' + auth.proxyUser.toString());
      return auth.proxyUser != null && auth.proxyUser.id != null
          ? AlertsList()
          : Login();
    });
  }
}
