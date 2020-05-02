import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/views/Report/report.dart';
import 'package:semester_5_project_mobile_app/views/alerts/alerts_list.dart';
import 'package:semester_5_project_mobile_app/views/profile/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'CommHawk',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
                Consumer<Authentication>(
                  builder: (context, auth, __) => Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${auth.user.firstName} ${auth.user.lastName}",
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          auth.user.email,
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text('Alerts'),
            leading: Icon(Icons.notification_important),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AlertsList(),
              ));
            },
          ),
          ListTile(
            title: Text('Report Incident'),
            leading: Icon(Icons.report),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Report(),
              ));
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Profile(),
              ));
            },
          ),
          Consumer<Authentication>(
            builder: (context, auth, _) => ListTile(
              title: Text('SignOut'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                auth.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
