import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/background_task.dart';
import 'package:semester_5_project_mobile_app/services/notification.dart';
import 'package:semester_5_project_mobile_app/views/alerts/alerts_list.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification =
        Provider.of<NotificationService>(context, listen: false);
    notification.initFCM();
    initBackgroundTask();
    return AlertsList();
  }
}
