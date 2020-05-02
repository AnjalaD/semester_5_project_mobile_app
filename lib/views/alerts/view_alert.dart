import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/alert.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/emg_numbers.dart';

class ViewAlert extends StatelessWidget {
  const ViewAlert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alert'),
        ),
        body: Alert(
          color: Colors.red[300],
          title: 'Curfew extended',
          date: '20 April 2020',
          time: '11:10AM',
          description:
              'Curfew imposed in the Colombo, Gampaha, Kalutara and Puttalam districts will be extended until 5am on April 27 (Monday), the President’s Media Division said today.\nPreviously the government had announced that the curfew in these districts will be lifted at 5 am and re-imposed at 8 pm on April 22 (Wednesday).\nMeanwhile, curfew in the remaining districts will be imposed at 8pm and lifted at 5am the other day daily until the 24th of April (Friday).\nThe curfew reimposed at 8 pm on the 24th of April will continue until 5 am on the 27th of April. Accordingly, curfew in these areas will be in effect throughout the weekend.',
          aditional: <Widget>[EmgNumbers()],
        ));
  }
}
