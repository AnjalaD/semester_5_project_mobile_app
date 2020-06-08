import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/alert.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/emg_numbers.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class ViewAlert extends StatelessWidget {
  const ViewAlert({
    Key key,
    this.title,
    this.description,
    this.color,
    this.date,
  }) : super(key: key);

  final String title;
  final String description;
  final Color color;
  final String date;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        title: 'Alert',
        body: Alert(
          color: color,
          title: title,
          date: date,
          time: '',
          description: description,
          aditional: <Widget>[],
        ));
  }
}
