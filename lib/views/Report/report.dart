import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/views/Report/widgets/report_form.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';

class Report extends StatelessWidget {
  const Report({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Report Incident'),
        ),
        drawer: CustomDrawer(),
        body: ListView(
          children: <Widget>[
            Container(
              // constraints: BoxConstraints.expand(height: 600),
              child: ReportForm(),
            ),
          ],
        ));
  }
}
