import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/models/alert_message.dart';
import 'package:semester_5_project_mobile_app/services/notification.dart';
import 'package:semester_5_project_mobile_app/views/alerts/view_alert.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/alert.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertsList extends StatelessWidget {
  const AlertsList({Key key}) : super(key: key);

  Future<List<AlertMessage>> loadAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('alerts');
    List<String> strings = prefs.getStringList('alerts');
    if (strings != null) {
      List<AlertMessage> temp = strings.map((json) {
        Map<String, dynamic> data = jsonDecode(json);
        return AlertMessage.fromJson(data);
      }).toList();
      return temp.reversed.toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Alerts',
      drawer: CustomDrawer(),
      body: Consumer<NotificationService>(
        builder: (context, _, __) => FutureBuilder<List<AlertMessage>>(
            future: loadAlerts(),
            initialData: [],
            builder: (context, snapshot) {
              List<AlertMessage> messages = snapshot.data;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewAlert(
                        title: messages[index].title,
                        description: messages[index].description,
                        color: messages[index].color,
                        date: messages[0].receivedOn,
                      ),
                    ));
                  },
                  child: Alert(
                    title: messages[index].title,
                    description: messages[index].description,
                    color: messages[index].color,
                    date: messages[0].receivedOn,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
