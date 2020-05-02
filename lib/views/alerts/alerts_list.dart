import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/views/alerts/widgets/list_item.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';

class AlertsList extends StatelessWidget {
  const AlertsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          ListItem(
            title: 'Fire',
            description:
                'A fire has erupted at a building in Hyde Park Corner, Union Place.',
            dateTime: 'Just now',
          ),
          ListItem(
            title: 'Thunder storm',
            description:
                'The Meteorology Department said that heavy falls of above 75 millimeters can be expected at some places in Sabaragamuwa and western provinces and in the Galle and Matara districts.',
            dateTime: 'Yesterday 8:20PM',
          ),
          ListItem(
            title: 'Curfew extended',
            description:
                'Curfew imposed in the Colombo, Gampaha, Kalutara and Puttalam districts will be extended until 5am on April 27 (Monday), the President’s Media Division said today.\nPreviously the government had announced that the curfew in these districts will be lifted at 5 am and re-imposed at 8 pm on April 22 (Wednesday).\nMeanwhile, curfew in the remaining districts will be imposed at 8pm and lifted at 5am the other day daily until the 24th of April (Friday).\nThe curfew reimposed at 8 pm on the 24th of April will continue until 5 am on the 27th of April. Accordingly, curfew in these areas will be in effect throughout the weekend.',
            dateTime: '20 April 2020 11:10AM',
            color: Colors.red[300],
          ),
          ListItem(
            title: 'Covid-19 | Safty precautions',
            description:
                'Wash your hands frequently\nRegularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.\nWhy? Washing your hands with soap and water or using alcohol-based hand rub kills viruses that may be on your hands.\n\nMaintain social distancing \nMaintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing.\nWhy? When someone coughs or sneezes they spray small liquid droplets from their nose or mouth which may contain virus. If you are too close, you can breathe in the droplets, including the COVID-19 virus if the person coughing has the disease.',
            dateTime: '2020 April 3:00PM',
            color: Colors.green[300],
          ),
        ],
      ),
    );
  }
}
